targetScope = 'resourceGroup'

@description('Custom base name used for generating unique resource names.')
param baseName string = 'thatsecguywebsite'

@description('Azure region for deploying the resources.')
param location string = resourceGroup().location

// Generate a unique suffix to ensure globally unique storage account names
var uniqueSuffix = substring(uniqueString(resourceGroup().id), 0, 6)
var storageAccountName = toLower('${baseName}${uniqueSuffix}')

// Call the modular storage template
module storageModule './modules/storage.bicep' = {
  name: 'storageDeployment'
  params: {
    storageAccountName: storageAccountName
    location: location
  }
}

@description('The name of the deployed storage account.')
output deployedStorageAccountName string = storageModule.outputs.storageAccountName

@description('The primary blob service endpoint URL.')
output primaryBlobEndpoint string = storageModule.outputs.primaryBlobEndpoint
