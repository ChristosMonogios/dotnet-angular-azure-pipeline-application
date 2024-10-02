@description('The name of the SQL logical server.')
param serverName string

@description('The name of the SQL Database.')
param sqlDBName string

@description('Location for all resources.')
param location string

@description('The administrator username of the SQL logical server.')
param administratorLogin string

@description('The administrator password of the SQL logical server.')
@secure()
param administratorLoginPassword string

@description('The name of the App Service plan.')
param appServicePlanName string

@description('The name of the App Service.')
param webAppName string

resource sqlServer 'Microsoft.Sql/servers@2023-08-01-preview' = {
  name: serverName
  location: location
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
  }
}

resource sqlDB 'Microsoft.Sql/servers/databases@2023-08-01-preview' = {
  parent: sqlServer
  name: sqlDBName
  location: location
  sku: {
    name: 'Basic'
    tier: 'Basic'
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: appServicePlanName
  location: location
  properties: {
    reserved: true
  }
  sku: {
    name: 'S1'
    tier: 'Standard'
  }
  kind: 'linux' // Do not forget to add this, otherwise you get the error that linuxFxVersion: 'DOTNETCORE|8.0' is not recognized
}

resource webApp 'Microsoft.Web/sites@2023-12-01' = {
  name: webAppName
  location: location
  kind: 'app,linux'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|8.0'
      appSettings: [
        {
          name: 'WEBSITE_RUN_FROM_PACKAGE' // Do not forget to add this, since we run the application from a .zip file
          value: '1'
        }
      ]
    }
  }
}
