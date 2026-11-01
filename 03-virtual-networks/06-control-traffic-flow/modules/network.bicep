@description('Azure region for deploying the network resources.')
param location string

@description('Name of the Virtual Network.')
param vnetName string = 'vnet'

@description('Route table containing custom UDRs to force traffic through the NVA.')
resource publicTable 'Microsoft.Network/routeTables@2023-09-01' = {
  name: 'publictable'
  location: location
  properties: {
    disableBgpRoutePropagation: false
    routes: [
      {
        name: 'productionsubnet'
        properties: {
          addressPrefix: '10.0.1.0/24'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '10.0.2.4'
        }
      }
    ]
  }
}

@description('Virtual Network with public, private, and DMZ subnets.')
resource vnet 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'publicsubnet'
        properties: {
          addressPrefix: '10.0.0.0/24'
          routeTable: {
            id: publicTable.id
          }
        }
      }
      {
        name: 'privatesubnet'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
      {
        name: 'dmzsubnet'
        properties: {
          addressPrefix: '10.0.2.0/24'
        }
      }
    ]
  }
}

output vnetId string = vnet.id
output publicSubnetId string = '${vnet.id}/subnets/publicsubnet'
output privateSubnetId string = '${vnet.id}/subnets/privatesubnet'
output dmzSubnetId string = '${vnet.id}/subnets/dmzsubnet'
