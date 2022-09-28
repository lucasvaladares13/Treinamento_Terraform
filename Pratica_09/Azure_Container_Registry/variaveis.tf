variable "location" {
  type        = string
  description = "Localização dos Recursos do Azure"
  default     = "brazilsouth"
}

variable "tags" {
    type = map
    description = "Tags nos Recursos e Serviços do Azure"
    default = {
        ambiente = "Desenvolvimento"
        responsavel = "lucas.oliveira"
    }
  
}

variable "name-rg" {
    type = string
    description = "Nome do Resource Group"
    default = "rg-variaveis"
  
}

variable "vnetadress" {
    type = list
    default = ["10.0.0.0/16", "192.168.0.0/16"]
  
}

variable "ambiente" {
    type = string
    description = "Ambientes DEV, TEST e PROD"
  
}

variable "regras_entrada" {
    type = map(any)
    default = {
      101 = 80
      102 = 443
      103 = 3389
      104 = 22
    }
  
}

