param name string
param location string
param logCustomerId string
param logClientSecret string

resource environment 'Microsoft.Web/kubeEnvironments@2021-03-01' = {
  name: name
  location: location
  properties: {
    environmentType: 'managed'
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: logCustomerId
        sharedKey: logClientSecret
      }
    }
  }
}

output environmentId string = environment.id
