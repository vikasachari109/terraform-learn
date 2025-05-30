data "azurerm_kubernetes_cluster" "ask-cluster-poc" {
  name = "ask-cluster-poc"
  resource_group_name = "aks-rg"
}

resource "kubernetes_manifest" "virtual_service" {
  manifest = yamlencode({
    apiVersion = "networking.istio.io/v1alpha3"
    kind       = "VirtualService"
    metadata = {
      name      = "${var.vs-name}"
      namespace = "default"
    }
    spec = {
      hosts = ["my-service"]
      gateways = ["my-gateway"]
      http = [{
        match = [{
          uri = {
            exact = "/my-path"
          }
        }]
        route = [{
          destination = {
            host = "my-service"
            port = {
              number = 80
            }
          }
        }]
      }]
    }
  })
}
