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
  instances = 2 # number of App Services instances
}

provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "main" {
  name     = "my-resource-group"
  location = "Southeast Asia"
}

resource "azurerm_app_service_plan" "main" {
  name                = "ap-my-app-plan"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  kind                = "Linux"
  sku {
    tier = ""
    size = ""
  }

}

resource "azurerm_app_service" "identityserver" {
  count               = local.instances
  name                = "thadaw-demo-multiple-deploy-${count.index}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  app_service_plan_id = azurerm_app_service_plan.main.id
  https_only          = true

  site_config {
    dotnet_framework_version = "v6.0"
    always_on                = true
  }

  app_settings = {

  }

}
