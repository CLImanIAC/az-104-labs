param location array
param environmentName string
param appName string

// - Network Layer (Using 3-region non-overlapping address spaces with 2 subnets each):
//   - Region 1 (West Europe): VNet vnet-teddycorp-westeurope (10.1.0.0/16), App Subnet (10.1.1.0/24), DB Subnet (10.1.2.0/24).
resource virtualNetworks 'Microsoft.Network/virtualNetworks@2023-11-01' = {
  name: 'vnet-${appName}-${environmentName}-${location[0]}'
  location: location[0]
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'app'
        properties: {
          addressPrefix: '10.1.1.0/24'
        }
      }
      {
        name: 'db'
        properties: {
          addressPrefix: '10.1.2.0/24'
        }
      }
    ]
  }
}

//   - Region 2 (North Europe): VNet vnet-teddycorp-northeurope (10.2.0.0/16), App Subnet (10.2.1.0/24), DB Subnet (10.2.2.0/24).
resource virtualNetworks2 'Microsoft.Network/virtualNetworks@2023-11-01' = {
  name: 'vnet-${appName}-${environmentName}-${location[1]}'
  location: location[1]
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.2.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'app'
        properties: {
          addressPrefix: '10.2.1.0/24'
        }
      }
      {
        name: 'db'
        properties: {
          addressPrefix: '10.2.2.0/24'
        }
      }
    ]
  }
}

//   - Region 3 (France Central): VNet vnet-teddycorp-francecentral (10.3.0.0/16), App Subnet (10.3.1.0/24), DB Subnet (10.3.2.0/24).
resource virtualNetworks3 'Microsoft.Network/virtualNetworks@2023-11-01' = {
  name: 'vnet-${appName}-${environmentName}-${location[2]}'
  location: location[2]
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.3.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'app'
        properties: {
          addressPrefix: '10.3.1.0/24'
        }
      }
      {
        name: 'db'
        properties: {
          addressPrefix: '10.3.2.0/24'
        }
      }
    ]
  }
}

//   - virtualNetworkNames: Array returning the names and IDs of all deployed regional virtual networks.
output vnetInfo array = [for (loc, i) in location: {
  region: loc
  name: i == 0 ? virtualNetworks.name : (i == 1 ? virtualNetworks2.name : virtualNetworks3.name)
  id: i == 0 ? virtualNetworks.id : (i == 1 ? virtualNetworks2.id : virtualNetworks3.id)
}]
