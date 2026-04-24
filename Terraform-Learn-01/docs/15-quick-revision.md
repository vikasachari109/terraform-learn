# Terraform Quick Revision

Use this file when you want a fast recap.

## Core Workflow

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

## Core Concepts

- provider: plugin used to talk to Azure or another platform
- resource: something Terraform manages
- data source: something Terraform reads
- variable: input from outside
- local: calculated value inside the module
- output: exported value
- module: reusable Terraform folder
- state: Terraform's record of managed resources

## Most Important Production Rules

- do not commit state to Git
- read every plan
- split state by ownership and blast radius
- pin provider versions
- avoid manual portal changes
- protect backend access

## Terraform File Roles

- `main.tf`: resources and module calls
- `variables.tf`: inputs
- `outputs.tf`: outputs
- `provider.tf` or `versions.tf`: provider setup
- `terraform.tfvars`: variable values

## `count` Vs `for_each`

- `count`: indexed resources
- `for_each`: keyed resources

In many production cases, prefer `for_each`.

## State Commands

```bash
terraform state list
terraform state show <resource>
terraform state mv <old> <new>
terraform state rm <resource>
terraform force-unlock <LOCK_ID>
```

## Azure Rules

- backend bootstrap should be separate
- shared network should not live in app state
- use tags consistently
- watch for name changes that force replacement

## If A Plan Looks Dangerous

1. stop
2. inspect the plan
3. confirm backend and subscription
4. compare code, state, and Azure
5. do not apply until you understand it
