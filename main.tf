terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.22.0"
    }
  }

}



provider "azurerm" {
  subscription_id = "200275a4-ad2c-4680-8fff-0c2629e48328"
  features {}
  # Configuration options

}





