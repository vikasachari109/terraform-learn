# Terraform Examples

These folders are arranged as a learning path, not as production-ready Terraform modules.

## Order

1. `01-azure-network-windows-vm`
   Basic Azure networking and VM provisioning
2. `02-aks-cluster-basics`
   Simple AKS cluster creation with outputs
3. `03-resource-group-tags`
   Small example showing variables and tags
4. `04-terraform-foundation`
   Terraform settings, providers, variables, outputs, and backend structure
5. `05-aks-cluster-advanced`
   AKS with Azure AD integration, version data, and Log Analytics
6. `06-istio-virtual-service`
   Kubernetes manifest management with supporting import notes
7. `07-aks-reference-manifests`
   Larger AKS reference configuration for comparison and reuse

## Before You Run Anything

- Update example names, locations, and backend settings for your own environment.
- Review every hardcoded value before `terraform apply`.
- Use `terraform init`, `terraform fmt`, `terraform validate`, and `terraform plan` first.
- Treat these folders as study material and starting points, not final production code.
