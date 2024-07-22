# Creamos Azure Kubernetes Cluster (AKS)
#   Ref: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
resource "azurerm_kubernetes_cluster" "myCluster" {
  name                = "agaakscp2"
  # ---
  # Debido a un problema de capacidad en la zona WestEurope generamos un grupo de recursos auxiliar en SpainCentral
  # en consecuencia, debido a la configuración de licencia, no se mostrarán estos los recursos en el Portal
  #resource_group_name = azurerm_resource_group.rgaks.name 
  #location = azurerm_resource_group.rgaks.location
  resource_group_name = azurerm_resource_group.rgaks.name 
  location = azurerm_resource_group.rgaks.location
  # --
  dns_prefix          = "agaakscp2"
  default_node_pool {
    name       = "default"
    node_count = "1"
    vm_size    = var.nodesize
  }
  identity {
    type = "SystemAssigned"
  }
  http_application_routing_enabled = true
  tags = {
    environment = var.environment
  }
}

# Generamos Kubeconfig para poder conectarlos al K8S
resource "local_file" "kubeconfig" {
  depends_on   = [azurerm_kubernetes_cluster.myCluster]
  filename     = "kubeconfig-akscp2"
  content      = azurerm_kubernetes_cluster.myCluster.kube_config_raw
}
