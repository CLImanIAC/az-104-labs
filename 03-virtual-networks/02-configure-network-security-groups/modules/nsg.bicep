@description('Target location for security resources.')
param location string

@description('Name of the VNet containing the target subnet.')
param vnetName string

@description('Name of the target subnet for NSG association.')
param subnetName string

// Application Security Group
resource asgWeb 'Microsoft.Network/applicationSecurityGroups@2025-09-01' = {
  name: 'asg-web'
  location: location
}

// Network Security Group with inbound and outbound rules
resource myNSGSecure 'Microsoft.Network/networkSecurityGroups@2025-09-01' = {
  name: 'myNSGSecure'
  location: location
  properties: {
    securityRules: [
      {
        name: 'AllowASG'
        properties: {
          priority: 100
          protocol: 'Tcp'
          access: 'Allow'
          direction: 'Inbound'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRanges: [
            '80'
            '443'
          ]
          sourceApplicationSecurityGroups: [
            {
              id: asgWeb.id
            }
          ]
        }
      }
      {
        name: 'DenyInternetOutbound'
        properties: {
          priority: 4096
          protocol: '*'
          access: 'Deny'
          direction: 'Outbound'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: 'Internet'
          destinationPortRange: '*'
        }
      }
    ]
  }
}

// Reference existing VNet and associate NSG to the target subnet
resource targetVnet 'Microsoft.Network/virtualNetworks@2025-09-01' existing = {
  name: vnetName
}

resource subnetNsgAssociation 'Microsoft.Network/virtualNetworks/subnets@2025-09-01' = {
  parent: targetVnet
  name: subnetName
  properties: {
    addressPrefix: '10.20.10.0/24'
    networkSecurityGroup: {
      id: myNSGSecure.id
    }
  }
}
