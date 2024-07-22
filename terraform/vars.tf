variable "location"{
    type = string
    description  = "Región Azure dónde se creará la infraestructura"
    default = "West Europe"
}

variable "environment"{
  type = string
  description = "Tag de entorno"
  default = "CP2" 
}

variable "vmsize"{
  type = string
  description = "Tamaño máquina virtual"
  default = "Standard_D1_V2" 
    # 1CPU - 3.5GB RAM
}

