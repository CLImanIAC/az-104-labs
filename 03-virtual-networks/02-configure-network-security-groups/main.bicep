targetScope = 'resourceGroup'

@description('Target region for all resources.')
param location string = 'eastus'

// 1. Deploy Virtual Networks and Subnets module
module vnets './modules/vnets.bicep' = {
  name: 'vnetsDeployment'
  params: {
    location: location
  }
}

// 2. Deploy Network Security Groups module (depends on VNet creation)
module nsg './modules/nsg.bicep' = {
  name: 'nsgDeployment'
  params: {
    location: location
    vnetName: 'CoreServicesVnet'
    subnetName: vnets.outputs.sharedServicesSubnetName
  }
}

// 3. Deploy DNS Zones module (passes Manufacturing VNet ID from the VNet module)
module dns './modules/dns.bicep' = {
  name: 'dnsDeployment'
  params: {
    manufacturingVnetId: vnets.outputs.manufacturingVnetId
  }
}
