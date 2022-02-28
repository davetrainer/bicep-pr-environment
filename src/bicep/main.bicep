param location string = resourceGroup().location

param containerImage string
param containerPort int
param registryServer string
param registryUsername string
param envName string
param registryResourceGroup string

@secure()
param registryPassword string

module log 'log.bicep' = {
    name: 'log-analytics-workspace'
    params: {
      location: location
      name: 'log-${envName}'
    }
}

module containerRegistry 'container-registry.bicep' = {
  name: 'container-registry'
  scope: resourceGroup(registryResourceGroup)
  params: {
    name: registryServer
  }
}

module containerAppEnvironment 'container-app-environment.bicep' = {
  name: 'container-app-environment'
  params: {
    name: 'container-env-${envName}'
    location: location
    logCustomerId:log.outputs.logCustomerId
    logClientSecret: log.outputs.logClientSecret
  }
}

module containerApp 'container-app.bicep' = {
  name: 'container-app'
  params: {
    name: 'container-app-${envName}'
    location: location
    containerAppEnvironmentId: containerAppEnvironment.outputs.environmentId
    containerImage: containerImage
    containerPort: containerPort
    useExternalIngress: true
    registry: containerRegistry.outputs.registryServer
    registryUsername: registryUsername
    registryPassword: registryPassword

  }
}
output fqdn string = containerApp.outputs.fqdn
