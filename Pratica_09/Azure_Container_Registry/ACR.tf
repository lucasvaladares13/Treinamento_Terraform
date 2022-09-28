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

resource "azurerm_container_group" "aci" {
  name = "aci-treinamentotf"
  location = azurerm_resource_group.grupo-recurso.location
  resource_group_name = azurerm_resource_group.grupo-recurso.name

  ip_address_type = "public"
  dns_name_label = "aci-treinamentotf"
  os_type = "Linux"

  image_registry_credential {
    username = azurerm_container_registry.acr.admin_username
    password = azurerm_container_registry.acr.admin_password
    server = azurerm_container_registry.acr.login_server
  }

  container {
    name = "acrregistrytf"
    image = "url da imagem"
    cpu = "0.5"
    memory = "1.5"

    ports {
      port = 443
      protocol = "TCP"

    }

    ports{
      port = 80
      protocol = "TCP"
    }
  }
  
}