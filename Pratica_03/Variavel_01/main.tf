provider "azurerm" {
  features {

  }
}

variable "location" {
  type        = string
  description = "Localização dos Recursos do Azure"
  default     = "brazilsouth"
}

resource "azurerm_resource_group" "grupo-recurso" {
  name     = "rg-variaveis"
  location = var.location

}
