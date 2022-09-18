provider "azurerm" {
    features {
      
    }
  
}

resource "azurerm_resource_group" "grupo-recurso" {
        count = 5
    location = "brazilsouth"
    name = "rg-terraform-${count.index}"
    tags = {
        data = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
        ambiente = lower("Homologacao")
        responsavel = upper("Lucas Valadares")
        tecnologia = title("hashcorp terraform")
    }
  
}

variable "vnetips" {
    type = list
    default = ["10.0.0.0/16"]
}
variable "vnetips_empty" {
    type = list
    default = []
  
}
resource "azurerm_virtual_network" "vnet" {
    name = "vnettreinamentoazure"
    location = "brazilsouth"
    resource_group_name = "rg-terraform-4"
    address_space = length(var.vnetips_empty) == 0 ? concat(var.vnetips, ["192.168.0.0/16"]) : var.vnetips_empty
  
}

output "vnet-numeroips" {
    value = length("${azurerm_virtual_network.vnet.address_space}")
  
}