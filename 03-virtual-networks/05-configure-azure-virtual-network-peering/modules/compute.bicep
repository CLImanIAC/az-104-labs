@description('Azure region for virtual machines')
param location string

@description('Subnet ID for CoreServicesVM')
param coreSubnetId string

@description('Subnet ID for ManufacturingVM')
param mfgSubnetId string

@description('Administrator username for VMs')
param adminUsername string

@description('Administrator password for VMs')
@secure()
param adminPassword string

// Network Interfaces
resource nicCore 'Microsoft.Network/networkInterfaces@2023-09-01' = {
  name: 'nic-core'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: { id: coreSubnetId }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
}

resource nicMfg 'Microsoft.Network/networkInterfaces@2023-09-01' = {
  name: 'nic-mfg'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: { id: mfgSubnetId }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
}

// Virtual Machines
resource coreServicesVM 'Microsoft.Compute/virtualMachines@2023-09-01' = {
  name: 'CoreServicesVM'
  location: location
  properties: {
    hardwareProfile: { vmSize: 'Standard_DS1_v2' }
    osProfile: {
      computerName: 'CoreServicesVM'
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2025-datacenter-g2'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: { storageAccountType: 'Standard_LRS' }
      }
    }
    networkProfile: {
      networkInterfaces: [{ id: nicCore.id }]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: false
      }
    }
  }
}

resource manufacturingVM 'Microsoft.Compute/virtualMachines@2023-09-01' = {
  name: 'ManufacturingVM'
  location: location
  properties: {
    hardwareProfile: { vmSize: 'Standard_DS1_v2' }
    osProfile: {
      computerName: 'ManufacturingVM'
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2025-datacenter-g2'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: { storageAccountType: 'Standard_LRS' }
      }
    }
    networkProfile: {
      networkInterfaces: [{ id: nicMfg.id }]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: false
      }
    }
  }
}
