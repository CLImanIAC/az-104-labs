// ==========================================
// PHASE 1: 01-MONOLITHIC-SKELETON (main.bicep)
// ==========================================

// - Define parameters and name resources according to conventions:
//   - Locations: westeurope, northeurope, and francecentral.
param location array = [
  'westeurope'
  'northeurope'
  'francecentral'
]
//   - Environment: dev.
param environmentName string = 'dev'
//   - Application name: teddycorp.
param appName string = 'teddycorp'


param sqlServerAdministratorLogin string = 'sqladmin'
param sqlServerAdministratorPassword string = 'P@ssw0rd1234!'

// - Network Layer (Using 3-region non-overlapping address spaces with 2 subnets each):
//   - Region 1 (West Europe): VNet vnet-teddycorp-westeurope (10.1.0.0/16), App Subnet (10.1.1.0/24), DB Subnet (10.1.2.0/24).
resource virtualNetworks 'Microsoft.Network/virtualNetworks@2023-11-01' = {
  name: 'vnet-${appName}-${location[0]}'
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
  name: 'vnet-${appName}-${location[1]}'
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
  name: 'vnet-${appName}-${location[2]}'
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
    administratorLogin: 'sqladmin'
    administratorLoginPassword: 'P@ssw0rd1234!'
  }
}


//   - SQL Databases: sqldb-teddycorp linked via the parent property to their respective server.


// - Compute & Monitoring Tier:
//   - Log Analytics: log-teddycorp-dev.
//   - Application Insights: appi-teddycorp-dev (linked to the Log Analytics workspace ID).
//   - App Service Plan & Web App: plan-teddycorp-dev and app-teddycorp-dev.


// - Security Tier:
//   - Key Vault: Store the SQL server administrator password.
//   - Resource Protection: Add a CanNotDelete Azure Resource Lock at the resource group level to prevent accidental deletion.


// - Validate the dependency graph in the VS Code Visualizer.
