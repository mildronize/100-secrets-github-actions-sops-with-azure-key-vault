# id,name,resourceGroup,subscription,slot

# Export app service info for https://github.com/dotnetthailand/azure-to-github 
# For automatic update secrets into github action
output "app_service_deployment" {
  value = [
    {
      id : "thadaw-demo-multiple-deploy-0",
      name : "",
      resourceGroup : "",
      subscription : "",
      slot: "production"
    },
    {
      id : "thadaw-demo-multiple-deploy-1",
      name : "",
      resourceGroup : "",
      subscription : "",
      slot: "production"
    }
  ]
}

