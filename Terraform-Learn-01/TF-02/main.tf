resource "azurerm_resource_group" "example" {
  name     = "${var.rg-name}"
  location = "${var.rg-location}"
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "${var.aks-cluster-name}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "akstfdemo"

  default_node_pool {
    name       = "medium1"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

    identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "example" {
  name                  = "internal"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.example.id
  vm_size               = "Standard_DS2_v2"
  node_count            = 1

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.example.kube_config[0].client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.example.kube_config_raw

  sensitive = true
}