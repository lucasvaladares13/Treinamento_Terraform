provider "azurerm" {
  features {

  }
}


resource "azurerm_resource_group" "grupo-recurso" {
  name     = var.name-rg
  location = var.location
  tags = merge(var.tags, {treinamento = "Terraform"
        sub-responsavel = "lucas.valadares"}) 

}

resource "azurerm_container_registry" "acr" {
    name = "acregistrytf"
    resource_group_name = azurerm_resource_group.grupo-recurso.name
    location = azurerm_resource_group.grupo-recurso.location
    sku = "Basic"
    admin_enabled = true
  
}