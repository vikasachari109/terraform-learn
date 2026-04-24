# Import Notes

Use placeholder IDs when you document imports.

## Import An Existing AKS Cluster

```bash
terraform import azurerm_kubernetes_cluster.cluster1 \
  /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.ContainerService/managedClusters/cluster1
```

## AKS Service Mesh Commands

```bash
az aks mesh enable --resource-group aks-rg --name demo-aks
az aks mesh enable-ingress-gateway --resource-group aks-rg --name demo-aks --ingress-gateway-type internal
```
