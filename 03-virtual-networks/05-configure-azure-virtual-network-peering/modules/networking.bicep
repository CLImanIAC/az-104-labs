@description('Azure region for virtual networks')
param location string

@description('Route Table ID to associate with the perimeter subnet')
param routeTableId string

@description('Core Services Virtual Network')
resource coreServicesVnet 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: 'CoreServicesVnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: ['10.0.0.0/16']
    }
    subnets: [
      {
        name: 'CoreSubnet'
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
      {
        name: 'perimeter'
        properties: {
          addressPrefix: '10.0.1.0/24'
          routeTable: {
            id: routeTableId
          }
        }
      }
    ]
  }
}

@description('Manufacturing Virtual Network')
resource manufacturingVnet 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: 'ManufacturingVnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: ['172.16.0.0/16']
    }
    subnets: [
      {
        name: 'ManufacturingSubnet'
        properties: {
          addressPrefix: '172.16.0.0/24'
        }
      }
    ]
  }
}

@description('Peering from CoreServicesVnet to ManufacturingVnet')
resource peeringCoreToMfg 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-09-01' = {
  parent: coreServicesVnet
  name: 'CoreServicesVnet-to-ManufacturingVnet'
  properties: {
    remoteVirtualNetwork: { id: manufacturingVnet.id }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
  }
}

@description('Peering from ManufacturingVnet to CoreServicesVnet')
resource peeringMfgToCore 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-09-01' = {
  parent: manufacturingVnet
  name: 'ManufacturingVnet-to-CoreServicesVnet'
  properties: {
    remoteVirtualNetwork: { id: coreServicesVnet.id }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
  }
}

// Outputs needed by other modules
output coreSubnetId string = '${coreServicesVnet.id}/subnets/CoreSubnet'
output mfgSubnetId string = '${manufacturingVnet.id}/subnets/ManufacturingSubnet'
