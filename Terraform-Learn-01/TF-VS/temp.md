terraform import azurerm_kubernetes_cluster.cluster1 /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.ContainerService/managedClusters/cluster1


terraform import azurerm_kubernetes_cluster.ask-cluster-poc /subscriptions/02580222-54b0-45d2-b7bd-8e95bf861521/resourceGroups/aks-rg/providers/Microsoft.ContainerService/managedClusters/ask-cluster-poc

-> zlf8Q~AwWFke0tJRlT~uJ4YouXCEMfkcWbTBzanM  // Value key client
-> 9d600260-f7cb-4a66-aff8-5a3ade15e487  // secret ID

-----

client iD = 3bb6f89f-6d07-4754-8c14-b79dfc21aad1
object id = c960b08e-5f9e-4ac7-9122-ee5b295b3d8f
tenent id = 48bde883-71a3-4e26-b37b-fccd6e71ef0c

client key = _618Q~9cdorfp8WqlC1Av13DXDpRFqysweGxra_g
secret id = ed1f5462-ca22-494f-8ad7-1416e4362ca9

----

az aks mesh enable --resource-group aks-rg --name ask-cluster-poc

az aks mesh enable-ingress-gateway --resource-group aks-rg --name ask-cluster-poc --ingress-gateway-type internal