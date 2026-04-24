# Terraform-Learn-01

This folder is the cleaned-up Terraform learning area for this repository. It now separates reference notes, reusable examples, and image assets so it is easier to study and safer to reuse.

## What Is Here

- `docs/`: concise notes for Terraform concepts, commands, data types, imports, and small automation snippets
- `examples/`: hands-on Terraform labs, ordered from basic to more advanced Azure and AKS examples
- `assets/images/`: screenshots and diagram-style learning images

## Suggested Study Order

1. Start with `docs/concepts.md`
2. Review `docs/commands.md`
3. Read `docs/data-types-and-expressions.md`
4. Skim `docs/study-qa-guide.md` for revision
5. Work through the folders in `examples/`

## Example Map

- `examples/01-azure-network-windows-vm`: resource group, VNet, subnet, NSG, NIC, and Windows VM
- `examples/02-aks-cluster-basics`: a simple AKS cluster with a node pool and outputs
- `examples/03-resource-group-tags`: a minimal resource group example with tags
- `examples/04-terraform-foundation`: providers, variables, backend stub, outputs, and a base resource group
- `examples/05-aks-cluster-advanced`: AKS with Azure AD and Log Analytics components
- `examples/06-istio-virtual-service`: notes and Terraform for a Kubernetes `VirtualService`
- `examples/07-aks-reference-manifests`: a larger AKS reference layout

## Good Learning Habits

- Run `terraform fmt` and `terraform validate` before applying changes.
- Keep secrets and real credentials out of Terraform files.
- Do not commit `terraform.tfstate` files to Git.
- Prefer a remote backend for shared environments.
- Use placeholder subscription IDs and resource IDs in documentation.

## Notes About The Cleanup

- Removed tracked state files and backup files from the examples
- Removed macOS metadata files such as `.DS_Store`
- Renamed `pratice-files` to `examples`
- Moved mixed text notes into a dedicated `docs` folder

Use `examples/README.md` as the quick index for the lab folders.
