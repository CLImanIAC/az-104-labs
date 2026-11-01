@description('Azure region for all deployed resources.')
param location string = resourceGroup().location

@description('Default administrator username for all virtual machines.')
param adminUsername string = 'azureuser'

@description('Default administrator password for all virtual machines.')
@secure()
param adminPassword string = 'Test1234tesT'

@description('Virtual machine size for the NVA and test nodes.')
param vmSize string = 'Standard_B2s'

@description('Deploying core networking infrastructure: VNet, subnets, and route tables.')
module network './modules/network.bicep' = {
  name: 'networkDeployment'
  params: {
    location: location
  }
}

@description('Deploying the Network Virtual Appliance with Azure and OS-level IP forwarding.')
module nva './modules/nva.bicep' = {
  name: 'nvaDeployment'
  params: {
    location: location
    dmzSubnetId: network.outputs.dmzSubnetId
    adminUsername: adminUsername
    adminPassword: adminPassword
    vmSize: vmSize
  }
}

@description('Deploying the public-facing test virtual machine with a public IP.')
module publicVm './modules/vm.bicep' = {
  name: 'publicVmDeployment'
  params: {
    vmName: 'public'
    location: location
    subnetId: network.outputs.publicSubnetId
    adminUsername: adminUsername
    adminPassword: adminPassword
    vmSize: vmSize
    createPublicIp: true
  }
}

@description('Deploying the private internal test virtual machine without a public IP.')
module privateVm './modules/vm.bicep' = {
  name: 'privateVmDeployment'
  params: {
    vmName: 'private'
    location: location
    subnetId: network.outputs.privateSubnetId
    adminUsername: adminUsername
    adminPassword: adminPassword
    vmSize: vmSize
    createPublicIp: false
  }
}

@description('Outputs public IP addresses for connectivity testing and validation.')
output nvaPublicIp string = nva.outputs.nvaPublicIp
output publicVmPublicIp string = publicVm.outputs.publicIp
