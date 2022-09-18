terraform {
  backend "azurerm" {
    resource_group_name = "terraformstate"
    storage_account_name = "terraformstateazprt05"
    container_name = "terraformstate"
    key = "Mtl/WdJMiyB8fWDSE7DSdTQe5SIImo6LzAdAWsQ86MnXMR7dM9tvKFMJvnWm93etWoRkTibAtEHe+AStHTipgQ=="  
    }
}

provider "azurerm" {
    features {
      
    }
  
}

resource "azurerm_resource_group" "rg-state" {
    name = "rg-terraform_com_state"
    location = "brazilsouth"
  
}