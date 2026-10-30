param location string = 'global'
param uniqueDomainName string
param vnetId string

// 1. Public DNS Zone (with a unique name to prevent global naming conflicts)
resource publicDnsZone 'Microsoft.Network/dnsZones@2018-05-01' = {
  name: uniqueDomainName
  location: location
}

// Example A record inside the public zone
resource wwwRecord 'Microsoft.Network/dnsZones/A@2018-05-01' = {
  parent: publicDnsZone
  name: 'www'
  properties: {
    TTL: 3600
    ARecords: [
      {
        ipv4Address: '10.10.10.10'
      }
    ]
  }
}

// 2. Private DNS Zone for internal name resolution within the VNet
resource privateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: 'private.contoso.com'
  location: location
}

// Linking the Private DNS Zone to the ManufacturingVnet
resource privateDnsLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: privateDnsZone
  name: 'manufacturing-link'
  location: location
  properties: {
    registrationEnabled: true
    virtualNetwork: {
      id: vnetId
    }
  }
}

// Example record inside the private zone
resource sensorRecord 'Microsoft.Network/privateDnsZones/A@2020-06-01' = {
  parent: privateDnsZone
  name: 'sensorvm'
  properties: {
    ttl: 3600
    aRecords: [
      {
        ipv4Address: '10.1.1.4'
      }
    ]
  }
}
