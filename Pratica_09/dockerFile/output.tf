output "admin-usuario" {
    value = azurerm_container_registry.acr.admin_username
  
}

output "admin-senha" {
    value = azurerm_container_registry.acr.admin_password
  
}


output "url" {
    value = azurerm_container_registry.acr.login_server
  
}
