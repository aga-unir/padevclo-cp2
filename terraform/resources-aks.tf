# Creamos Azure Kubernetes Cluster (AKS)
#   Ref: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
resource "azurerm_kubernetes_cluster" "cluster" {
  name                = "agaakscp2"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  dns_prefix          = "agaakscp2"
  default_node_pool {
    name       = "default"
    node_count = "1"
    vm_size    = var.nodesize
  }
  identity {
    type = "SystemAssigned"
  }
  tags = {
    environment = var.environment
  }
}
