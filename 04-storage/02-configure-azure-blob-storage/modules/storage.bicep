targetScope = 'resourceGroup'

@description('Name of the storage account to create.')
param storageAccountName string

@description('Location for the storage account.')
param location string

@description('Storage account SKU. Set to Standard_RAGRS for Read-access geo-redundant storage.')
param storageSku string = 'Standard_RAGRS'

@description('Blob soft delete retention days.')
param softDeleteDays int = 21

// 1. Create Storage Account with RA-GRS and public access allowed
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageSku
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    networkAcls: {
      defaultAction: 'Allow'
    }
  }
}

// 2. Configure Blob Service settings (Soft Delete and Versioning)
resource blobServices 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
  parent: storageAccount
  name: 'default'
  properties: {
    deleteRetentionPolicy: {
      enabled: true
      days: softDeleteDays
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: softDeleteDays
    }
    isVersioningEnabled: true
  }
}

// 3. Create public blob container with anonymous read access
resource publicContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  parent: blobServices
  name: 'public'
  properties: {
    publicAccess: 'Blob'
  }
}

@description('Output the created storage account name.')
output storageAccountName string = storageAccount.name

@description('Output the primary blob endpoint URL.')
output primaryBlobEndpoint string = storageAccount.properties.primaryEndpoints.blob
