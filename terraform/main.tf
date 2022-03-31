terraform {
  required_version = ">= 1.1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.94"
    }
  }

}

locals {
  # instances = 2 # number of App Services instances
  instance_names   = ["cat", "dog", "ant"]
  scope = "demo-multi-app"
  org = "thadaw"
  env = "demo"
  resource_group   = "rg-${local.org}-${local.env}-${local.scope}"
  app_service_plan = "ap-${local.org}-${local.env}-${local.scope}"
  subscription     = "Azure Subscription"

  output_servers = [for name in local.instance_names :  {
    id : join("_", [local.env, replace(local.scope, "-", "_"), name]),
    name : "${local.org}-${local.scope}-${name}",
    resourceGroup : local.resource_group,
    subscription : local.subscription,
    slot : "production"
  }]
}

provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "main" {
  name     = local.resource_group
  location = "East Asia"
}

resource "azurerm_app_service_plan" "main" {
  name                = local.app_service_plan
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  kind                = "Linux"
  reserved = true

  sku {
    tier = "Free"
    size = "F1"
  }

}

resource "azurerm_app_service" "web_api" {
  for_each            = toset(local.instance_names)
  name                = "thadaw-demo-multi-app-${each.key}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  app_service_plan_id = azurerm_app_service_plan.main.id
  https_only          = true

  site_config {
    dotnet_framework_version = "v6.0"

    # when using an App Service Plan in the Free or Shared Tiers use_32_bit_worker_process must be set to true.
    use_32_bit_worker_process = true
    # when using an App Service Plan in the Free, always_on must be to false
  }

}
