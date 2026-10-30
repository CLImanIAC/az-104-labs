targetScope = 'resourceGroup'

param location string = resourceGroup().location
param uniqueDomainName string = 'wideworldimports-${uniqueString(resourceGroup().id)}.com'

// Call Virtual Networks Module
module vnetsModule './modules/vnets.bicep' = {
  name: 'vnetsDeployment'
  params: {
    location: location
  }
}

// Call Network Security Groups Module (uses subnet ID from VNet module output)
module nsgModule './modules/nsg.bicep' = {
  name: 'nsgDeployment'
  params: {
    location: location
    subnetId: vnetsModule.outputs.subnetId
  }
}

// Call DNS Module (uses VNet ID from VNet module output)
module dnsModule './modules/dns.bicep' = {
  name: 'dnsDeployment'
  params: {
    uniqueDomainName: uniqueDomainName
    vnetId: vnetsModule.outputs.vnetId
  }
}
