# Terraform Commands Reference

This file is the quick command reference for daily use.

## Setup

```bash
terraform version
terraform init
terraform fmt
terraform fmt -recursive
terraform validate
terraform providers
```

## Planning And Applying

```bash
terraform plan
terraform plan -out=tfplan
terraform apply
terraform apply tfplan
terraform destroy
```

## Variables And Outputs

```bash
terraform plan -var="location=East US"
terraform plan -var-file="dev.tfvars"
terraform output
terraform output -json
```

## Workspaces

```bash
terraform workspace list
terraform workspace new dev
terraform workspace select dev
terraform workspace delete dev
```

## State Commands

```bash
terraform show
terraform state list
terraform state show <resource_address>
terraform state mv <old_address> <new_address>
terraform state rm <resource_address>
terraform state pull
terraform force-unlock <LOCK_ID>
```

## Import

```bash
terraform import <resource_address> <resource_id>
```

## Good Habit

A strong everyday sequence is:

```bash
terraform fmt
terraform validate
terraform plan
```
