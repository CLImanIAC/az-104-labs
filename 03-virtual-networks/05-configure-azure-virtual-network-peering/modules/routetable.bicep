@description('Azure region for route table')
param location string

@description('Custom Route Table for Core Services VNet')
resource rtCoreServices 'Microsoft.Network/routeTables@2023-09-01' = {
  name: 'rt-CoreServices'
  location: location
  properties: {
    disableBgpRoutePropagation: false
    routes: [
      {
        name: 'PerimetertoCore'
        properties: {
          addressPrefix: '10.0.0.0/16'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '10.0.1.7'
        }
      }
    ]
  }
}

output routeTableId string = rtCoreServices.id
