# provider "azurerm" {
#   features = {}
# }

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  dns_prefix                      = var.dns_prefix
  node_resource_group             = azurerm_resource_group.rg.name
  # enable_rbac                     = true
  kubernetes_version              = "1.22.0"
  # node_count                      = var.node_count
  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.vm_size
  }
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
}
