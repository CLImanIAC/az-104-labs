param location array
param environmentName string
param appName string


// // - Compute Tier:
// //   - App Service Plans: plan-teddycorp-westeurope, plan-teddycorp-northeurope, and plan-teddycorp-francecentral.
// resource appServicePlans 'Microsoft.Web/serverfarms@2024-04-01' = {
//   name: 'plan-${appName}-${environmentName}-${location[0]}'
//   location: location[0]
//   sku: {
//     name: 'F1'
//     tier: 'Free'
//     capacity: 1
//   }
// }

// resource appServicePlans2 'Microsoft.Web/serverfarms@2024-04-01' = {
//   name: 'plan-${appName}-${environmentName}-${location[1]}'
//   location: location[1]
//   sku: {
//     name: 'F1'
//     tier: 'Free'
//     capacity: 1
//   }
// }

// resource appServicePlans3 'Microsoft.Web/serverfarms@2024-04-01' = {
//   name: 'plan-${appName}-${environmentName}-${location[2]}'
//   location: location[2]
//   sku: {
//     name: 'F1'
//     tier: 'Free'
//     capacity: 1
//   }
// }

//   // - Web Apps: app-teddycorp-westeurope, app-teddycorp-northeurope, and app-teddycorp-francecentral linked via parent/serverFarmId.
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

//   // - webAppUrl: Retrieved via webApp.properties.defaultHostName (the public URL of the web application - note: uncomment once Compute tier quota is resolved).
// output webAppUrl array = [for (loc, i) in location: {
//   region: loc
//   appName: i == 0 ? appServiceApps.name : (i == 1 ? appServiceApps2.name : appServiceApps3.name)
//   defaultHostName: i == 0 ? appServiceApps.properties.defaultHostName : (i == 1 ? appServiceApps2.properties.defaultHostName : appServiceApps3.properties.defaultHostName)
// }]
