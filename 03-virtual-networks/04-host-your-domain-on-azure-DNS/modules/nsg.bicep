param location string = resourceGroup().location
param subnetId string

resource sensorNsg 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: 'SensorSubnet-NSG'
  location: location
  properties: {
    securityRules: [
      {
        name: 'Allow-Inbound-Telemetry'
        properties: {
          priority: 100
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

// Associating the NSG with the Subnet
resource subnetNsgLink 'Microsoft.Network/virtualNetworks/subnets@2023-04-01' = {
  name: '${split(subnetId, '/')[8]}/SensorSubnet-NSG-Link'
  properties: {
    addressPrefix: '10.1.1.0/24'
    networkSecurityGroup: {
      id: sensorNsg.id
    }
  }
}
