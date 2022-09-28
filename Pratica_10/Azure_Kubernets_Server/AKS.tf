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

resource "azurerm_kubernetes_cluster" "aks" {
  name = "akstf"
  location = azurerm_resource_group.grupo-recurso.location
  resource_group_name = azurerm_resource_group.grupo-recurso.name

  dns_prefix = "akstf"

  default_node_pool {
    
    name = "agentpool"
    node_count = 2
    vm_size = "Standard_B2s"
  }
  identity {
    type = "SystemAssigned"
  }
  
}

resource "azurerm_role_assignment" "aks_acr" {
  scope = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  
}