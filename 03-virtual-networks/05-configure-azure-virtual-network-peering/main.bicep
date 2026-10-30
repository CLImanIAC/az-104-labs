targetScope = 'resourceGroup'

@description('Azure region for deployment')
param location string = 'austriaeast'

@description('Administrator username for virtual machines')
param adminUsername string = 'localadmin'

@description('Administrator password for virtual machines')
@secure()
param adminPassword string

// 1. Deploy Route Table first (needed for VNet subnet association)
module routeTableModule './modules/routetable.bicep' = {
  name: 'routeTableDeployment'
  params: {
    location: location
  }
}

// 2. Deploy VNets and Peerings using the Route Table ID
module networkingModule './modules/networking.bicep' = {
  name: 'networkingDeployment'
  params: {
    location: location
    routeTableId: routeTableModule.outputs.routeTableId
  }
}

// 3. Deploy Virtual Machines in respective subnets
module computeModule './modules/compute.bicep' = {
  name: 'computeDeployment'
  params: {
    location: location
    coreSubnetId: networkingModule.outputs.coreSubnetId
    mfgSubnetId: networkingModule.outputs.mfgSubnetId
    adminUsername: adminUsername
    adminPassword: adminPassword
  }
}
