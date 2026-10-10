param location array
param environmentName string
param appName string

// - Define secure parameters for SQL Server administrator login.
@secure()
param sqlServerAdministratorLogin string

// - Define secure parameters for SQL Server administrator password.
@secure()
param sqlServerAdministratorLoginPassword string

// - Database Tier:
//   - SQL Servers: sql-teddycorp-westeurope, sql-teddycorp-northeurope, and sql-teddycorp-francecentral.
resource sqlServers 'Microsoft.Sql/servers@2023-08-01' =  {
  name: 'sql-${appName}-${environmentName}-${location[0]}'
  location: location[0]
  properties: {
    administratorLogin: sqlServerAdministratorLogin
    administratorLoginPassword: sqlServerAdministratorLoginPassword
  }
}

resource sqlServers2 'Microsoft.Sql/servers@2023-08-01' =  {
  name: 'sql-${appName}-${environmentName}-${location[1]}'
  location: location[1]
  properties: {
    administratorLogin: sqlServerAdministratorLogin
    administratorLoginPassword: sqlServerAdministratorLoginPassword
  }
}

resource sqlServers3 'Microsoft.Sql/servers@2023-08-01' =  {
  name: 'sql-${appName}-${environmentName}-${location[2]}'
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

//   - sqlServerFqdns / sqlServerInfo: Array/loop returning Fully Qualified Domain Names for all regional SQL servers (e.g., sql-teddycorp-dev-swedencentral.database.windows.net).
output sqlServerInfo array = [for (loc, i) in location: {
  region: loc
  serverName: i == 0 ? sqlServers.name : (i == 1 ? sqlServers2.name : sqlServers3.name)
  fullyQualifiedDomainName: i == 0 ? sqlServers.properties.fullyQualifiedDomainName : (i == 1 ? sqlServers2.properties.fullyQualifiedDomainName : sqlServers3.properties.fullyQualifiedDomainName)
}]

//   - sqlDatabaseInfo: Array returning database names and IDs for all regional SQL databases.
output sqlDatabaseInfo array = [for (loc, i) in location: {
  region: loc
  databaseName: i == 0 ? sqlDatabases.name : (i == 1 ? sqlDatabases2.name : sqlDatabases3.name)
  skuName: i == 0 ? sqlDatabases.sku.name : (i == 1 ? sqlDatabases2.sku.name : sqlDatabases3.sku.name)
  skuTier: i == 0 ? sqlDatabases.sku.tier : (i == 1 ? sqlDatabases2.sku.tier : sqlDatabases3.sku.tier)
}]

// - sqlServer just one location and all objects
// output sqlServerInfo object = {
//   serverName: sqlServers.name
//   fullyQualifiedDomainName: sqlServers.properties.fullyQualifiedDomainName
// }

// - sqlServer just one location and one string
// output sqlServerInfo string = sqlServers.properties.fullyQualifiedDomainName
