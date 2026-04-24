terraform import azurerm_kubernetes_cluster.cluster1 /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.ContainerService/managedClusters/cluster1


terraform import azurerm_kubernetes_cluster.ask-cluster-poc /subscriptions/02580222-54b0-45d2-b7bd-8e95bf861521/resourceGroups/aks-rg/providers/Microsoft.ContainerService/managedClusters/ask-cluster-poc


----

az aks mesh enable --resource-group aks-rg --name ask-cluster-poc

az aks mesh enable-ingress-gateway --resource-group aks-rg --name ask-cluster-poc --ingress-gateway-type internal