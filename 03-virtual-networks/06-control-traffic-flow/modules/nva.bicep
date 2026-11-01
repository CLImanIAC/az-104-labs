@description('Azure region for deploying the Network Virtual Appliance.')
param location string

@description('Subnet ID where the NVA will be placed (DMZ subnet).')
param dmzSubnetId string

@description('Administrator username for the NVA virtual machine.')
param adminUsername string

@description('Administrator password for the NVA virtual machine.')
@secure()
param adminPassword string

@description('Virtual machine size for the NVA.')
param vmSize string

@description('Public IP address resource for external access and testing.')
resource nvaPublicIp 'Microsoft.Network/publicIPAddresses@2023-09-01' = {
  name: 'nva-pip'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

@description('Network interface card with IP Forwarding explicitly enabled.')
resource nvaNic 'Microsoft.Network/networkInterfaces@2023-09-01' = {
  name: 'nva-nic'
  location: location
  properties: {
    ipForwarding: true
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: dmzSubnetId
          }
          privateIPAllocationMethod: 'Static'
          privateIPAddress: '10.0.2.4'
          publicIPAddress: {
            id: nvaPublicIp.id
          }
        }
      }
    ]
  }
}

@description('Virtual machine instance acting as the Network Virtual Appliance.')
resource nvaVm 'Microsoft.Compute/virtualMachines@2024-03-01' = {
  name: 'nva'
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: 'nva'
      adminUsername: adminUsername
      adminPassword: adminPassword
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
          id: nvaNic.id
        }
      ]
    }
  }
}

@description('Custom script extension to automatically enable IP forwarding at the Linux kernel level.')
resource enableIpForwarding 'Microsoft.Compute/virtualMachines/extensions@2024-03-01' = {
  parent: nvaVm
  name: 'enable-ip-forwarding'
  location: location
  properties: {
    publisher: 'Microsoft.Azure.Extensions'
    type: 'CustomScript'
    typeHandlerVersion: '2.1'
    autoUpgradeMinorVersion: true
    settings: {
      commandToExecute: 'sysctl -w net.ipv4.ip_forward=1 && echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf'
    }
  }
}

output nvaPublicIp string = nvaPublicIp.properties.ipAddress
