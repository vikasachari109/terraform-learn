# Terraform-Learn-01

This folder is now organized as a cleaner beginner-to-expert Terraform learning workspace. The docs have been simplified into a numbered learning path with more detailed explanations, Azure examples, and a clearer flow based on the concept image sequence.

## What Is Here

- `docs/`: a guided Terraform course from beginner basics to advanced Azure real-world topics
- `examples/`: hands-on Terraform labs, ordered from basic to more advanced Azure and AKS examples
- `assets/images/`: screenshots and diagram-style learning images

## Best Starting Point

Start with [docs/README.md](./docs/README.md). It is now the index for the whole learning path.

## Expert Study Order

1. `docs/01-learning-roadmap.md`
2. `docs/02-terraform-fundamentals.md`
3. `docs/03-providers.md`
4. `docs/04-resources.md`
5. `docs/05-variables-types-outputs-and-locals.md`
6. `docs/06-state-backends-locking-and-workspaces.md`
7. `docs/07-provisioners-and-dependency-handling.md`
8. `docs/08-modules-and-folder-structure.md`
9. `docs/09-data-sources-import-and-brownfield.md`
10. `docs/10-azure-real-world-terraform.md`
11. `docs/11-backups-restore-and-disaster-recovery.md`
12. `docs/12-breaking-scenarios-drift-and-troubleshooting.md`
13. `docs/13-advanced-patterns-security-testing-and-ci-cd.md`
14. `docs/14-interview-questions.md`
15. `docs/15-quick-revision.md`
16. `docs/16-commands-reference.md`
17. Work through the folders in `examples/`

## Handbook Topics

The `docs/` folder now includes clearer material for:

- Terraform from scratch
- providers and resources
- variables, data types, outputs, and locals
- state, backends, locking, and workspaces
- provisioners and dependency handling
- modules and folder structure
- data sources and brownfield import
- Azure real-world architecture and operations
- backups, restore, and troubleshooting
- advanced patterns, security, CI/CD, and interview prep

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
- Read every plan carefully before approving destructive actions.
- Keep secrets and real credentials out of Terraform files.
- Do not commit `terraform.tfstate` files to Git.
- Prefer a remote backend for shared environments.
- Use placeholder subscription IDs and resource IDs in documentation.
- Practice state recovery and drift scenarios, not just happy-path provisioning.

## Notes About The Cleanup

- Removed tracked state files and backup files from the examples
- Removed macOS metadata files such as `.DS_Store`
- Renamed `pratice-files` to `examples`
- Rebuilt the `docs` folder into a numbered learning path
- Removed duplicate and unnecessary note files

Use [docs/README.md](./docs/README.md) as the main handbook index and [examples/README.md](./examples/README.md) as the quick index for the labs.
