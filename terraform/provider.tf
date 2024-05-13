terraform {
  required_version = ">=1.0"

  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    # time = {
    #   source  = "hashicorp/time"
    #   version = "0.9.1"
    # }
  }

  backend "azurerm" {
    resource_group_name  = "rg01"
    storage_account_name = "storage0101010101010101"
    container_name       = "data2"
    key                  = "terraform.tfstate"

  }
}


provider "azurerm" {
  features {}
}
