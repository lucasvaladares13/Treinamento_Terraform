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

resource "azurerm_virtual_network" "vnet" {
  name = "vnet-terraform-treinamento"
  resource_group_name = "${azurerm_resource_group.grupo-recurso.name}"
  location = var.location
  address_space = var.vnetadress
  
}

resource "azurerm_subnet" "subnet" {
    name = "vmwinserver-subnet"
    resource_group_name = "${azurerm_resource_group.grupo-recurso.name}"
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = ["10.0.2.0/24"]

  
}

resource "azurerm_public_ip" "publicip" {
    name = "vmwinserver-ippublic"
    location = var.location
    resource_group_name = "${azurerm_resource_group.grupo-recurso.name}"
    allocation_method = "Dynamic"
    idle_timeout_in_minutes = 30
    domain_name_label = "vmwinserver"

}

resource "azurerm_network_interface" "nic" {
    name = "vmwinserver-nic"
    location = var.location
    resource_group_name = "${azurerm_resource_group.grupo-recurso.name}"

    ip_configuration {
      name = "ipexterno-config"
      subnet_id = azurerm_subnet.subnet.id
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id = azurerm_public_ip.publicip.id
    }

  
}

resource "azurerm_network_security_group" "nsg" {
    name = "vmwinserver-nsg"
    location = var.location
    resource_group_name = "${azurerm_resource_group.grupo-recurso.name}"
      
}

resource "azurerm_network_security_rule" "regras_entrada_liberada" {
    for_each = var.regras_entrada
    resource_group_name = "${azurerm_resource_group.grupo-recurso.name}"
    name = "porta_entrada_${each.value}"
    priority = each.key
    direction = "Inbound"
    access = "Allow"
    source_port_range = "*"
    protocol = "Tcp"
    destination_port_range = each.value
    source_address_prefix = "*"
    destination_address_prefix = "*"
    network_security_group_name = azurerm_network_security_group.nsg.name

  
}

resource "azurerm_subnet_network_security_group_association" "nsgassociacao" {
    subnet_id = azurerm_subnet.subnet.id
    network_security_group_id = azurerm_network_security_group.nsg.id
  
}

resource "azurerm_windows_virtual_machine" "vmwin" {
    name = "vmwinserver"
    location = var.location
    resource_group_name = "${azurerm_resource_group.grupo-recurso.name}"

    size = "Standard_B1ls"
    admin_username = "admin"
    admin_password = "12345678"

    network_interface_ids = [azurerm_network_interface.nic.id]

    os_disk {
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference {
      publisher = "MicrosoftWindowsServer"
      offer = "WindowsServer"
      sku = "2016-Datacenter"
      version = "latest"
    }

  
}
























