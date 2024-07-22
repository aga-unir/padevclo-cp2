# Creamos Storage Account
#   Ref: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
resource "azurerm_storage_account" "stAccount" {
  name = "vmstaccount"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  account_tier = "Standard"
  account_replication_type = "LRS"
  tags = {
    environment = var.environment
  }
}

# -- NETWORK --------------------------

# Creamos Network
#   Ref: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
resource "azurerm_virtual_network" "myNet" {
  name = "vmnet"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  address_space = ["10.0.0.0/16"]
  tags = {
    environment = var.environment
  }
}

# Creamos Subnet
resource "azurerm_subnet" "mySubnet" {
  name = "vmsubnet"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.myNet.name
  address_prefixes = ["10.0.1.0/24"]
}

# Creamos PublicIP
#   Ref: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip
resource "azurerm_public_ip" "myPublicIp1" {
  name = "vmip1"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  allocation_method = "Dynamic"
  sku = "Basic"
  tags = {
    environment = var.environment
  }
}

# Creamos NIC
#   Ref: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface
resource "azurerm_network_interface" "myNic1" {
  name = "vmnic1"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  ip_configuration {
    name = "myipconfiguration1"
    subnet_id = azurerm_subnet.mySubnet.id
    private_ip_address_allocation = "Static"
    private_ip_address = "10.0.1.10"
    public_ip_address_id = azurerm_public_ip.myPublicIp1.id
  }
  tags = {
    environment = var.environment
  }
}

# -- SECURITY -------------------------

# Creamos Security Group
#   Ref: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group
resource "azurerm_network_security_group" "mySecurityGroup" {
  name = "sshtraffic" 
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
 
  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  
  tags = {
    environment = var.environment
  }
}

# Asociamos Security Group a NIC
#   Ref: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.myNic1.id
  network_security_group_id = azurerm_network_security_group.mySecurityGroup.id
}

# -- VM -------------------------------

# Creamos Linux VM
#   Ref: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine
resource "azurerm_linux_virtual_machine" "myVM1" {
  name                = "vmlinux1"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  size                = var.vmsize
  admin_username      = "adminuser"
  network_interface_ids = [azurerm_network_interface.myNic1.id]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("../ssh/id_rsa_azcp2.pub")
      # No se incorporará al repositorio la clave pública
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  
  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.stAccount.primary_blob_endpoint
  }
  
  tags = {
    environment = var.environment
  }
}