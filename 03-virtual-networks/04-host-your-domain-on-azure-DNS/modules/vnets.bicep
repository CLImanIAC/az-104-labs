param location string = resourceGroup().location

resource manufacturingVnet 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: 'ManufacturingVnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'SensorSubnet'
        properties: {
          addressPrefix: '10.1.1.0/24'
        }
      }
    ]
  }
}

output vnetId string = manufacturingVnet.id
output subnetId string = manufacturingVnet.properties.subnets[0].id
