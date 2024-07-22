variable "location"{
    type = string
    description  = "Región Azure dónde se creará la infraestructura"
    default = "West Europe"
}

variable "akslocation"{
    type = string
    description  = "Región Azure dónde se creará la infraestructura"
    default = "Spain Central"
}

variable "environment"{
  type = string
  description = "Tag de entorno"
  default = "CP2" 
}

variable "vmsize"{
  type = string
  description = "Tamaño máquina virtual"
  default = "Standard_D1_v2" 
    # 1CPU - 3.5GB RAM
}

# Ref:https://azure.microsoft.com/en-ca/pricing/details/virtual-machines/linux/#pricing
variable "nodesize"{
  type = string
  description = "Tamaño nodo AKS"
  default = "Standard_D2_v2" 
    # 2CPU - 7GB RAM
}


