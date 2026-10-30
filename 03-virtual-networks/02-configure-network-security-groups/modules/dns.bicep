@description('Manufacturing VNet resource ID for private DNS linking.')
param manufacturingVnetId string

// Public DNS Zone configuration
resource publicDnsZone 'Microsoft.Network/dnsZones@2018-05-01' = {
  name: 'contoso104lab.com'
  location: 'global'
}

resource publicDnsArecord 'Microsoft.Network/dnsZones/A@2018-05-01' = {
  parent: publicDnsZone
  name: 'www'
  properties: {
    TTL: 1
    ARecords: [
      {
        ipv4Address: '10.1.1.4'
      }
    ]
  }
}

// Private DNS Zone configuration
resource privateDnsZone 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: 'private.contoso.com'
  location: 'global'
}

resource privateDnsLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: privateDnsZone
  name: 'manufacturing-link'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: manufacturingVnetId
    }
  }
}

resource privateDnsArecord 'Microsoft.Network/privateDnsZones/A@2024-06-01' = {
  parent: privateDnsZone
  name: 'sensorvm'
  properties: {
    ttl: 1
    aRecords: [
      {
        ipv4Address: '10.1.1.4'
      }
    ]
  }
}
