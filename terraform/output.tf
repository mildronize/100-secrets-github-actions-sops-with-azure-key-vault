# id,name,resourceGroup,subscription,slot

# Export app service info for https://github.com/dotnetthailand/azure-to-github 
# For automatic update secrets into github action
output "app_service_deployment" {
  value = local.output_servers
}

