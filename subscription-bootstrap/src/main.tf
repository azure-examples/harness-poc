terraform {
  required_version = ">= 0.14, < 0.15"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.49.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "default" {
  name     = "devops"
  location = "Central US"
}

resource "azurerm_storage_account" "default" {
  name = "devops${substr(replace(var.ARM_SUBSCRIPTION_ID, "-", ""), 0, 18)}"
  resource_group_name      = azurerm_resource_group.default.name
  location                 = azurerm_resource_group.default.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
}

resource "azurerm_storage_container" "default" {
  name                 = "tfstate"
  storage_account_name = azurerm_storage_account.default.name
}
