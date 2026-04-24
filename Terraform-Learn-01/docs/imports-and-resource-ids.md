# Terraform Imports And Resource IDs

Terraform import connects an existing resource to a Terraform resource address in your configuration.

## Import Pattern

```bash
terraform import <terraform_resource_address> <provider_resource_id>
```

### What each part means

- `<terraform_resource_address>`: the resource name from your Terraform code
- `<provider_resource_id>`: the full ID used by the provider, such as an Azure resource ID

## Example: Import An Azure Resource Group

```bash
terraform import azurerm_resource_group.example \
  /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/demo-rg
```

## Example: Import An AKS Cluster

```bash
terraform import azurerm_kubernetes_cluster.example \
  /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/aks-rg/providers/Microsoft.ContainerService/managedClusters/demo-aks
```

## Good Practices

- Make sure the resource already exists in your `.tf` code before importing it.
- Use placeholder IDs in documentation instead of real subscription values.
- Run `terraform plan` after import to compare your code with the real resource.
- Use `terraform state list` and `terraform state show` to verify the imported object.

## Remote State Reminder

For team environments, keep Terraform state in a remote backend with locking instead of storing `terraform.tfstate` in Git.
