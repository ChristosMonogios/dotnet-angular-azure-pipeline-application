# dotnet-angular-azure-pipeline-application

**A .NET & Angular application that uses an Azure DevOps pipeline for deployment on multiple environments**

You can find more information about how the Azure DevOps pipeline of this repository works [in a tutorial I wrote on my personal blog](https://christosmonogios.com/2024/10/03/deploy-a-dotnet-and-angular-application-to-an-azure-app-service-with-multiple-environments-using-an-azure-pipeline/).

In the tutorial you can learn:

- How to use pipeline templates to simplify the structure of our pipeline
- How to use multiple stages to split semantically different jobs
- How to use multiple Azure environments by elevating the power of a for loop in the pipeline
- How to use Bicep for setting up the needed Azure infrastructure
- How to deploy the application on an Azure App Service by using different deployment slots
