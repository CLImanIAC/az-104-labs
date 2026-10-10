// ==========================================
// PHASE 2: 02-REFACTORING AND MODULARIZATION (main.bicep)
// ==========================================

// - Define parameters and name resources according to conventions:
//   - Locations: swedencentral, francecentral, and germanywestcentral.
param location array
//   - Environment: dev.
param environmentName string
//   - Application name: teddycorp.
param appName string

// - Define secure parameters for SQL Server administrator login.
@secure()
param sqlServerAdministratorLogin string

// - Define secure parameters for SQL Server administrator password.
@secure()
param sqlServerAdministratorLoginPassword string

module network 'modules/network.bicep' = {
  name: 'network'
  params: {
    location: location
    environmentName: environmentName
    appName: appName
  }
}

module databases 'modules/database.bicep' = {
  name: 'databases'
  params: {
    location: location
    environmentName: environmentName
    appName: appName
    sqlServerAdministratorLogin: sqlServerAdministratorLogin
    sqlServerAdministratorLoginPassword: sqlServerAdministratorLoginPassword
  }
}

module compute 'modules/compute.bicep' = {
  name: 'compute'
  params: {
    location: location
    environmentName: environmentName
    appName: appName
  }
}

// - Security Tier:
//   - Resource Protection: Add a CanNotDelete Azure Resource Lock at the resource group level to prevent accidental deletion.
resource resourceGroupLock 'Microsoft.Authorization/locks@2020-05-01' = {
  name: 'rg-lock-${appName}'
  properties: {
    level: 'CanNotDelete'
    notes: 'This lock prevents accidental deletion of the resource group and its resources.'
  }
}

output vnetInfo array = network.outputs.vnetInfo
output sqlServerInfo array = databases.outputs.sqlServerInfo
output sqlDatabaseInfo array = databases.outputs.sqlDatabaseInfo
// output webAppUrl array = compute.outputs.webAppUrl

// - Validate the dependency graph in the VS Code Visualizer.
