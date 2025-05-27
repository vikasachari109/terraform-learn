# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  client_id       = "9060a74c-69ed-46ab-bf8e-205b3e8ec36c"
  client_secret   = "UL88Q~smxKmo1agbldwWuURUp2zyrNUsfM1xhcfC"
  tenant_id       = "48bde883-71a3-4e26-b37b-fccd6e71ef0c"
  subscription_id = "02580222-54b0-45d2-b7bd-8e95bf861521"
}