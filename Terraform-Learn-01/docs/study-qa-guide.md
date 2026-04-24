# Terraform Study Q&A Guide

This page is a quick revision sheet for common Terraform concepts.

## Modules And Variables

### What is a Terraform module?

A module is a directory that contains Terraform configuration files. The folder where you run Terraform is the root module, and any module called with a `module` block is a child module.

### Which variables must be passed to a module?

Required variables are the ones that do not define a default value. Optional variables already have a default and can be overridden when needed.

### How do you pass module inputs?

```hcl
module "network" {
  source   = "./modules/network"
  rg_name  = "demo-rg"
  location = "eastus"
}
```

### How should sensitive values be handled?

- Mark variables as `sensitive = true`
- Use secret managers or CI/CD secret stores
- Avoid committing real secrets to Git

## Workspaces

### What is a workspace?

A workspace lets one configuration keep separate state for different environments such as `dev`, `qa`, or `prod`.

### Common workspace commands

```bash
terraform workspace list
terraform workspace new dev
terraform workspace select dev
```

## State Management

### What is the state file?

`terraform.tfstate` is Terraform's record of the infrastructure it manages. Terraform uses it to understand what already exists and what should change.

### Why is state important?

- It maps Terraform resources to real infrastructure
- It helps Terraform calculate changes safely
- It stores metadata and dependencies

### State best practices

- Keep state out of Git
- Use remote state for team workflows
- Enable locking where supported
- Restrict access to state because it may contain sensitive values

## Backends

### What is a backend?

A backend controls where state is stored and how operations such as locking are handled.

### Why use a remote backend?

- Better team collaboration
- Centralized state storage
- Locking support
- Improved recovery and auditing

### Example Azure backend

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-rg"
    storage_account_name = "tfstorageaccount"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}
```

## Terraform Cloud

### What is Terraform Cloud?

Terraform Cloud is HashiCorp's hosted platform for Terraform workflows, remote runs, state storage, and collaboration.

### When is it useful?

- Team-based workflows
- Remote execution
- Centralized policy and governance
- VCS-driven automation

## Revision Prompts

- Explain the difference between the root module and a child module.
- Describe the order you follow before running `terraform apply`.
- Explain why remote state is better than committing local state files.
- Compare `count` and `for_each`.
- Explain when you would use outputs, locals, and variables.
