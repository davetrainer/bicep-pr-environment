param location string
param name string

resource logWorkSpace 'Microsoft.OperationalInsights/workspaces@2021-12-01-preview' = {
  name: name
  location: location
  properties: any({
    retentionInDays: 30
    features: {
      searchVersion: 1
    }
    sku: {
      name: 'PerGB2018'
    }
  })
}

output logCustomerId string = logWorkSpace.properties.customerId
output logClientSecret string = logWorkSpace.listKeys().primarySharedKey
