@description('Name of the virtual machine.')
param vmName string

@description('Azure region for deploying the virtual machine.')
param location string

@description('Subnet ID where the virtual machine will be connected.')
param subnetId string

@description('Administrator username.')
param adminUsername string

@description('Administrator password.')
@secure()
param adminPassword string

@description('Virtual machine size.')
param vmSize string

@description('Flag to determine if a public IP should be created for this VM.')
param createPublicIp bool = false

@description('Optional public IP address for external connectivity.')
resource publicIp 'Microsoft.Network/publicIPAddresses@2023-09-01' = if (createPublicIp) {
  name: '${vmName}-pip'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

@description('Network interface card for the virtual machine.')
resource nic 'Microsoft.Network/networkInterfaces@2023-09-01' = {
  name: '${vmName}-nic'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnetId
          }
          publicIPAddress: createPublicIp ? {
            id: publicIp.id
          } : null
        }
      }
    ]
  }
}

@description('Virtual machine deployment resource with cloud-init configuration.')
resource vm 'Microsoft.Compute/virtualMachines@2024-03-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
      customData: base64('#cloud-config\npackage_upgrade: true\npackages:\n  - inetutils-traceroute')
      linuxConfiguration: {
        disablePasswordAuthentication: false
      }
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: 'UbuntuServer'
        sku: '18.04-LTS'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
  }
}

output publicIp string = createPublicIp ? publicIp.properties.ipAddress : ''
