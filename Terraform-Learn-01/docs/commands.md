# Terraform Commands

This is a practical command list for day-to-day Terraform work.

## Setup And Validation

```bash
terraform version
terraform init
terraform validate
terraform fmt
terraform fmt -recursive
terraform providers
```

- `terraform version`: show the installed Terraform version
- `terraform init`: initialize the working directory
- `terraform validate`: check configuration syntax and internal consistency
- `terraform fmt`: format Terraform files
- `terraform providers`: show the providers required by the configuration

## Plan And Apply

```bash
terraform plan
terraform plan -out=tfplan
terraform apply
terraform apply tfplan
terraform destroy
```

- `terraform plan`: preview infrastructure changes
- `terraform plan -out=tfplan`: save a plan to a file
- `terraform apply`: apply the configuration interactively
- `terraform apply tfplan`: apply the previously saved plan
- `terraform destroy`: remove managed infrastructure

## Variables And Outputs

```bash
terraform plan -var-file="dev.tfvars"
terraform apply -var="location=eastus"
terraform output
terraform output -json
```

- `-var-file`: load variables from a file
- `-var`: pass a value directly from the command line
- `terraform output`: show output values

## Workspaces

```bash
terraform workspace list
terraform workspace new dev
terraform workspace select dev
terraform workspace delete dev
```

Use workspaces when the same configuration needs separate state for multiple environments.

## State Commands

```bash
terraform show
terraform state list
terraform state show <resource_address>
terraform state rm <resource_address>
terraform state pull
terraform state push
terraform force-unlock <LOCK_ID>
```

- `terraform show`: display the current state or a saved plan
- `terraform state list`: list tracked resources
- `terraform state show`: inspect one tracked resource
- `terraform state rm`: remove an object from state without deleting the real resource
- `terraform state pull`: download remote state
- `terraform state push`: upload local state to a backend
- `terraform force-unlock`: unlock a stuck state lock

## Pipeline-Friendly Commands

```bash
terraform fmt -check
terraform validate
terraform plan -input=false -out=tfplan
terraform apply -input=false tfplan
```

These commands are useful in CI/CD workflows because they reduce interactive prompts and make validation predictable.
