@description('Target location for the Virtual Networks.')
param location string

// CoreServicesVnet deployment with dedicated subnets
resource coreServicesVnet 'Microsoft.Network/virtualNetworks@2025-09-01' = {
  name: 'CoreServicesVnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.20.0.0/16'
      ]
    }
  }
}

resource sharedServicesSubnet 'Microsoft.Network/virtualNetworks/subnets@2025-09-01' = {
  parent: coreServicesVnet
  name: 'SharedServicesSubnet'
  properties: {
    addressPrefix: '10.20.10.0/24'
  }
}

resource databaseSubnet 'Microsoft.Network/virtualNetworks/subnets@2025-09-01' = {
  parent: coreServicesVnet
  name: 'DatabaseSubnet'
  properties: {
    addressPrefix: '10.20.20.0/24'
  }
}

// ManufacturingVnet deployment with dedicated subnets
resource manufacturingVnet 'Microsoft.Network/virtualNetworks@2025-09-01' = {
  name: 'ManufacturingVnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.30.0.0/16'
      ]
    }
  }
}

resource sensorSubnet1 'Microsoft.Network/virtualNetworks/subnets@2025-09-01' = {
  parent: manufacturingVnet
  name: 'SensorSubnet1'
  properties: {
    addressPrefix: '10.30.20.0/24'
  }
}

resource sensorSubnet2 'Microsoft.Network/virtualNetworks/subnets@2025-09-01' = {
  parent: manufacturingVnet
  name: 'SensorSubnet2'
  properties: {
    addressPrefix: '10.30.21.0/24'
  }
}

// Outputs required for other modules
output coreServicesVnetId string = coreServicesVnet.id
output manufacturingVnetId string = manufacturingVnet.id
output sharedServicesSubnetName string = sharedServicesSubnet.name
