terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.22.0"
    }
  }
}



provider "azurerm" {
  features {

  }
}

resource "azurerm_resource_group" "grupo-recurso" {
  name     = "rgterraform"
  location = "brazilsouth"
}
