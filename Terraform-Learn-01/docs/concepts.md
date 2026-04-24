# Terraform Concepts

This note collects the Terraform basics that show up again and again in the examples in this repository.

## What Terraform Is

Terraform is an Infrastructure as Code tool from HashiCorp. It uses a declarative approach, which means you describe the target state you want and Terraform calculates the changes needed to reach it.

Terraform is commonly used to provision and manage:

- cloud resources such as VMs, VNets, AKS clusters, and storage
- platform services such as databases and identity resources
- local or test resources when learning Terraform fundamentals

## Core Workflow

The standard workflow is:

1. Write or update `.tf` files
2. Run `terraform init`
3. Run `terraform plan`
4. Run `terraform apply`

### `terraform init`

- downloads required providers and modules
- initializes the working directory
- prepares backend configuration

### `terraform plan`

- compares configuration with current state
- shows the proposed changes before anything is created or updated

### `terraform apply`

- executes the approved changes
- updates the Terraform state after the operation finishes

## HCL Basics

Terraform configuration uses HashiCorp Configuration Language, usually stored in `.tf` files.

```hcl
resource "local_file" "pet" {
  filename = "/tmp/pets.txt"
  content  = "We love pets!"
}
```

In this example:

- `resource` is the block type
- `local_file` is the resource type
- `pet` is the local name used inside Terraform
- `filename` and `content` are arguments

## Important Building Blocks

### Providers

Providers connect Terraform to a platform or service such as Azure, AWS, Kubernetes, or the local system.

```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}
```

### Resources

A resource is any object Terraform manages, such as a resource group, subnet, VM, or AKS cluster.

### Variables

Variables make configurations reusable.

```hcl
variable "location" {
  type        = string
  description = "Azure region for the deployment"
  default     = "eastus"
}
```

Use variables in resources with `var.<name>`.

### Outputs

Outputs expose useful values after an apply, such as resource IDs, names, or endpoints.

```hcl
output "resource_group_name" {
  value = azurerm_resource_group.example.name
}
```

### Data Sources

Data sources read information that already exists instead of creating it.

```hcl
data "azurerm_kubernetes_service_versions" "current" {
  location = var.location
}
```

## Recommended File Layout

Common file names in a Terraform folder are:

- `main.tf`: primary resources or module calls
- `providers.tf` or `provider.tf`: provider and version settings
- `variables.tf`: input variables
- `outputs.tf`: outputs
- `terraform.tfvars`: example input values for local runs

Terraform reads all `.tf` files in a directory together, so the split is for organization, not for execution order.

## Dependencies

Terraform usually figures out dependencies automatically when one resource references another.

```hcl
resource "azurerm_subnet" "app" {
  virtual_network_name = azurerm_virtual_network.main.name
}
```

If you need to force an ordering relationship, use `depends_on`.

## State

Terraform stores its working record in a state file. State helps Terraform understand:

- what it created before
- which real resources map to which Terraform resources
- what must be changed next

Important rules:

- do not commit state files to Git
- protect state because it may contain sensitive data
- use a remote backend for team environments

## Learning Tip

When you study an example in this repository, identify these five things first:

1. provider configuration
2. variables
3. resources being created
4. outputs
5. whether a backend or existing data source is involved
