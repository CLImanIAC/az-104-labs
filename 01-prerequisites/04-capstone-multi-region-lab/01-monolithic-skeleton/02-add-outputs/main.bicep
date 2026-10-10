// ==========================================
// PHASE 1: 01-MONOLITHIC-SKELETON (main.bicep)
// ==========================================

// - Define parameters and name resources according to conventions:
//   - Locations: swedencentral, francecentral, and germanywestcentral.
param location array = [
  'swedencentral'
  'francecentral'
  'germanywestcentral'
]
//   - Environment: dev.
param environmentName string = 'dev'
//   - Application name: teddycorp.
param appName string = 'teddycorp'

// - Define secure parameters for SQL Server administrator login.
@secure()
param sqlServerAdministratorLogin string

// - Define secure parameters for SQL Server administrator password.
@secure()
param sqlServerAdministratorLoginPassword string

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

// - Database Tier:
//   - SQL Servers: sql-teddycorp-westeurope, sql-teddycorp-northeurope, and sql-teddycorp-francecentral.
resource sqlServers 'Microsoft.Sql/servers@2023-08-01' =  {
  name: 'sql-${appName}-${location[0]}'
  location: location[0]
  properties: {
    administratorLogin: sqlServerAdministratorLogin
    administratorLoginPassword: sqlServerAdministratorLoginPassword
  }
}

resource sqlServers2 'Microsoft.Sql/servers@2023-08-01' =  {
  name: 'sql-${appName}-${location[1]}'
  location: location[1]
  properties: {
    administratorLogin: sqlServerAdministratorLogin
    administratorLoginPassword: sqlServerAdministratorLoginPassword
  }
}

resource sqlServers3 'Microsoft.Sql/servers@2023-08-01' =  {
  name: 'sql-${appName}-${location[2]}'
  location: location[2]
  properties: {
    administratorLogin: sqlServerAdministratorLogin
    administratorLoginPassword: sqlServerAdministratorLoginPassword
  }
}

//   - SQL Databases: sqldb-teddycorp linked via the parent property to their respective server.
resource sqlDatabases 'Microsoft.Sql/servers/databases@2023-08-01' = {
  parent: sqlServers
  name: 'sqldb-${appName}'
  location: location[0]
  sku: {
    name: 'S0'
    tier: 'Standard'
  }
}

resource sqlDatabases2 'Microsoft.Sql/servers/databases@2023-08-01' = {
  parent: sqlServers2
  name: 'sqldb-${appName}'
  location: location[1]
  sku: {
    name: 'S0'
    tier: 'Standard'
  }
}

resource sqlDatabases3 'Microsoft.Sql/servers/databases@2023-08-01' = {
  parent: sqlServers3
  name: 'sqldb-${appName}'
  location: location[2]
  sku: {
    name: 'S0'
    tier: 'Standard'
  }
}

// - Compute Tier:
//   - App Service Plans: plan-teddycorp-westeurope, plan-teddycorp-northeurope, and plan-teddycorp-francecentral.
// resource appServicePlans 'Microsoft.Web/serverfarms@2024-04-01' = {
//   name: 'plan-${appName}-${location[0]}'
//   location: location[0]
//   sku: {
//     name: 'F1'
//     tier: 'Free'
//     capacity: 1
//   }
// }

// resource appServicePlans2 'Microsoft.Web/serverfarms@2024-04-01' = {
//   name: 'plan-${appName}-${location[1]}'
//   location: location[1]
//   sku: {
//     name: 'F1'
//     tier: 'Free'
//     capacity: 1
//   }
// }

// resource appServicePlans3 'Microsoft.Web/serverfarms@2024-04-01' = {
//   name: 'plan-${appName}-${location[2]}'
//   location: location[2]
//   sku: {
//     name: 'F1'
//     tier: 'Free'
//     capacity: 1
//   }
// }

//   - Web Apps: app-teddycorp-westeurope, app-teddycorp-northeurope, and app-teddycorp-francecentral linked via parent/serverFarmId.
// resource appServiceApps 'Microsoft.Web/sites@2024-04-01' = {
//   name: 'app-${appName}-${location[0]}'
//   location: location[0]
//   properties: {
//     serverFarmId: appServicePlans.id
//     httpsOnly: true
//   }
// }

// resource appServiceApps2 'Microsoft.Web/sites@2024-04-01' = {
//   name: 'app-${appName}-${location[1]}'
//   location: location[1]
//   properties: {
//     serverFarmId: appServicePlans2.id
//     httpsOnly: true
//   }
// }

// resource appServiceApps3 'Microsoft.Web/sites@2024-04-01' = {
//   name: 'app-${appName}-${location[2]}'
//   location: location[2]
//   properties: {
//     serverFarmId: appServicePlans3.id
//     httpsOnly: true
//   }
// }

// - Security Tier:
//   - Resource Protection: Add a CanNotDelete Azure Resource Lock at the resource group level to prevent accidental deletion.
resource resourceGroupLock 'Microsoft.Authorization/locks@2020-05-01' = {
  name: 'rg-lock-${appName}'
  properties: {
    level: 'CanNotDelete'
    notes: 'This lock prevents accidental deletion of the resource group and its resources.'
  }
}

// - Validate the dependency graph in the VS Code Visualizer.

// - Define output blocks at the bottom of the script:
//   - sqlServerFqdns: Array/loop returning Fully Qualified Domain Names for all regional SQL servers (e.g., sql-teddycorp-swedencentral.database.windows.net).
output sqlServerFqdns array = [
  sqlServers.properties.fullyQualifiedDomainName
  sqlServers2.properties.fullyQualifiedDomainName
  sqlServers3.properties.fullyQualifiedDomainName
]

//   - virtualNetworkNames: Array returning the names of all deployed regional virtual networks.
output virtualNetworkNames array = [
  virtualNetworks.name
  virtualNetworks2.name
  virtualNetworks3.name
]

// - Define output block for testing a single virtual network:
output singleVnetName string = virtualNetworks.name

//   - webAppUrl: Retrieved via webApp.properties.defaultHostName (the public URL of the web application - note: uncomment once Compute tier quota is resolved).
// output webAppUrl array = [
//   appServiceApps.properties.defaultHostName
//   appServiceApps2.properties.defaultHostName
//   appServiceApps3.properties.defaultHostName
// ]
