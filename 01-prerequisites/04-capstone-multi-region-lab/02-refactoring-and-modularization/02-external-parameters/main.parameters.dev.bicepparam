using 'main.bicep'

//   - Locations: swedencentral, francecentral, and germanywestcentral.
param location = [
  'swedencentral'
  'francecentral'
  'germanywestcentral'
]
//   - Environment: dev.
param environmentName = 'dev'
//   - Application name: teddycorp.
param appName = 'teddycorp'

// - Define secure parameters for SQL Server administrator login.
param sqlServerAdministratorLogin = 'SuperDuperAdmin'

// - Define secure parameters for SQL Server administrator password.
param sqlServerAdministratorLoginPassword = 'Admin1337!'
