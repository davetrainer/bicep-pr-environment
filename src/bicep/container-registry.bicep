param name string

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2021-12-01-preview' existing = {
  name: name
}

output registryServer string = containerRegistry.properties.loginServer
