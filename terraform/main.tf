# Especificamos Azure Provider Source y Version
#   Ref: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.94.0"
    }
  }
}

# Realizamos login mediante: az login --use-device-code
provider "azurerm" {
  features {}
}

# Creamos Azure Resource Group
#   Ref: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "rg" {
  name     = "UNIR"
  location = var.location
}

resource "azurerm_resource_group" "rgaks" {
  name     = "UNIRAKS"
  location = var.akslocation
}

