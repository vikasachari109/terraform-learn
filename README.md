# terraform-learn
# Terraform Learning: Q\&A Guide

This guide provides a structured Question & Answer format to help you learn Terraform through practical examples and explanations. It covers modules, variables, workspaces, state management, remote backends, Terraform Cloud, and best practices.

---

## 🔧 Terraform Modules & Variable Handling

### Q1: What is a Terraform module?

**A:** A module in Terraform is a container for multiple resources that are used together. Every `.tf` file in a directory is part of a module. The root configuration itself is a module, and you can also call child modules to organize and reuse code.

### Q2: How do you call a module in Terraform?

```hcl
module "example" {
  source = "./path-to-module"
  var1   = "value"
  var2   = "value"
}
```

### Q3: How do you know which variables to pass to a module?

**A:**

* Open the module's `variables.tf`.
* Identify variables without a `default` value (required).
* Those with `default` values are optional.

### Q4: In this example, which variables are required in the root module?

```hcl
variable "rgname" {}
variable "location" { default = "eastus" }
variable "prefix" {}
variable "vnet_cidr_prefix" {}
variable "subnet1_cidr_prefix" {}
variable "subnet" {}
```

**A:** Required: `rgname`, `prefix`, `vnet_cidr_prefix`, `subnet1_cidr_prefix`, `subnet`. Optional: `location`

### Q5: Why is `location` not required?

**A:** Because it has a default value defined in `variables.tf`.

### Q6: What happens if you forget to pass a required variable?

**A:** Terraform will throw an error at plan or apply stage, stating the missing variable.

### Q7: Can you override optional variables?

**A:** Yes, optional variables can be overridden by passing a new value.

### Q8: What is the benefit of using modules?

**A:** Code reuse, consistency, maintainability, and abstraction.

### Q9: Root vs. Child Modules?

**A:** Root: where Terraform is run. Child: invoked via the `module` block.

### Q10: How do you pass sensitive values securely?

**A:**

* Mark variables as `sensitive = true`
* Use `.tfvars` files (never commit to Git)
* Use environment variables (`TF_VAR_` prefix)

### Q11: Scenario-Based: Which variable is optional?

```hcl
module "module_dev" {
  source              = "./modules"
  prefix              = "dev"
  vnet_cidr_prefix    = "10.20.0.0/16"
  subnet1_cidr_prefix = "10.20.1.0/24"
  rgname              = "DevRG"
  subnet              = "DevSubnet"
}
```

**A:** `location`, if the module has a default for it.

### Q12: How can you validate required module variables?

**A:**

* Check `variables.tf`
* Use `terraform validate`, `tflint`, or `terraform-docs`

---

## 📊 Terraform Workspaces

### Q13: What is a workspace?

**A:** A workspace is an isolated instance of Terraform state used for managing different environments like `dev`, `qa`, `prod`.

### Q14: How to create and switch workspaces?

```bash
terraform workspace new dev
terraform workspace select dev
```

### Q15: Where are workspace states stored?

**A:** Locally under `.terraform/` or in the remote backend.

---

## 📊 Terraform State Management

### Q16: What is the state file?

**A:** Tracks resources and metadata. File: `terraform.tfstate`

### Q17: Why is it important?

**A:** Maintains infrastructure consistency and prevents drift.

### Q18: Best practices for state management?

* Use remote backends
* Enable locking
* Encrypt state
* Don’t store state in Git

---

## 📂 Remote Backends

### Q19: What is a remote backend?

**A:** Remote location for storing state files like Azure, AWS S3, Terraform Cloud.

### Q20: Why use a remote backend?

* Collaboration
* State locking
* Secure storage
* Versioning

### Q21: Azure Remote Backend Configuration

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

---

## ☁️ Terraform Cloud & Enterprise

### Q22: What is Terraform Cloud?

**A:** SaaS offering from HashiCorp for collaboration, remote state storage, policy enforcement, and CI/CD integrations.

### Q23: What is Terraform Enterprise?

**A:** Self-hosted version of Terraform Cloud with advanced features like SSO, policy as code (Sentinel), private networking.

### Q24: Key Features of Terraform Cloud:

* Remote state backend with locking
* VCS integration (GitHub, GitLab, etc.)
* CLI-driven workflows
* Workspaces for environment isolation
* Role-based access control

### Q25: How to configure Terraform Cloud backend?

```hcl
terraform {
  backend "remote" {
    organization = "my-org"
    workspaces {
      name = "dev"
    }
  }
}
```

---

## 🔒 State Locking and Security

### Q26: What is state locking?

**A:** Prevents concurrent `terraform apply` or `plan` operations from corrupting the state file.

### Q27: How is state locking managed?

**A:**

* **S3 backend:** Uses DynamoDB table for locking
* **Azure backend:** Uses blob lease
* **Terraform Cloud:** Built-in locking

### Q28: Security Best Practices for State:

* Use remote backend with encryption
* Enable versioning in storage (e.g., Azure Blob, S3)
* Set access policies (RBAC/IAM)
* Avoid hardcoding secrets — use Vault or environment variables

---

## ⚖️ Miscellaneous

### Q29: What is `terraform.tfvars`?

**A:** A file to define variable values automatically loaded by Terraform.

### Q30: Difference between `terraform plan` and `apply`?

**A:**

* `plan`: Shows changes
* `apply`: Executes changes

### Q31: Purpose of `terraform output`?

**A:** Prints output variables useful for integration or debugging.

### Q32: How to destroy resources?

```bash
terraform destroy
```

---

## 🧠 Terraform Functions and Meta-Arguments

### Q33: What is `count` used for?

```hcl
resource "azurerm_resource_group" "example" {
  count    = 3
  name     = "example-rg-${count.index}"
  location = "eastus"
}
```

**Use when:** You need a fixed number of identical resources.

### Q34: What is `for_each`?

```hcl
variable "tags" {
  default = {
    env = "dev"
    team = "platform"
  }
}

resource "azurerm_resource_group" "example" {
  for_each = var.tags
  name     = "rg-${each.key}"
  location = "eastus"
}
```

**Use when:** Resources have unique values.

### Q35: `join` function

```hcl
output "joined_string" {
  value = join(", ", ["apple", "banana", "cherry"])
}
```

**Output:** `apple, banana, cherry`

### Q36: `map` usage

```hcl
variable "custom_tags" {
  default = {
    environment = "dev"
    owner       = "vikas"
  }
}
```

### Q37: `lookup` function

```hcl
output "owner" {
  value = lookup(var.custom_tags, "owner", "default-owner")
}
```

### Q38: `element` function

```hcl
variable "locations" {
  default = ["eastus", "westeurope", "centralus"]
}
output "first_location" {
  value = element(var.locations, 0)
}
```

### Q39: Creating dynamic nested resources (e.g., NSG rules)

```hcl
resource "azurerm_network_security_group" "nsg" {
  name                = "example-nsg"
  location            = "eastus"
  resource_group_name = "example-rg"

  dynamic "security_rule" {
    for_each = var.rules
    content {
      name                       = each.key
      priority                   = each.value.priority
      direction                  = each.value.direction
      access                     = each.value.access
      protocol                   = each.value.protocol
      source_port_range          = each.value.source_port_range
      destination_port_range     = each.value.destination_port_range
      source_address_prefix      = each.value.source_address_prefix
      destination_address_prefix = each.value.destination_address_prefix
    }
  }
}
```

---

## 🧯 Drift Management & State Recovery

### Q40: How to recover state or manage drift?

1. Use `terraform refresh` to sync state:

```bash
terraform refresh
```

2. Import existing resources:

```bash
terraform import azurerm_resource_group.example /subscriptions/.../my-rg
```

3. Use `terraform state` commands to manipulate state.
4. Restore previous versions if using versioned storage backend.

---

## 🎯 Medium to Advanced Interview Questions (Q41+)

### Q41: How would you manage multiple environments using Terraform?

**A:**

* Use Workspaces (`dev`, `qa`, `prod`)
* Separate variable files (`dev.tfvars`, `prod.tfvars`)
* Remote state with different keys
* Environment-specific modules if needed

### Q42: How can you implement blue-green deployments in Terraform?

**A:**

* Use `count` or `for_each` to spin up green resources alongside blue
* Use load balancer rules to toggle traffic
* Destroy blue only after green is validated

### Q43: Scenario: You've accidentally deleted the remote backend state file. What would you do?

**A:**

* If versioning is enabled on backend (Azure/S3), restore last known state
* Otherwise, re-import resources using `terraform import`

### Q44: How do you manage secrets securely in Terraform?

**A:**

* Use Azure Key Vault, AWS Secrets Manager, or HashiCorp Vault
* Avoid hardcoding secrets
* Use `sensitive = true` for variables
* Use environment variables or CI/CD vault integration

### Q45: How can you dynamically create subnets based on a list of CIDRs?

```hcl
variable "subnet_cidrs" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

resource "azurerm_subnet" "subnet" {
  for_each             = toset(var.subnet_cidrs)
  name                 = "subnet-${replace(each.value, "/", "-")}"
  address_prefixes     = [each.value]
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = var.rgname
}
```

---

### Module and Workspace Structure in Terraform (Azure-focused)

Terraform promotes modular, reusable, and environment-specific configurations using modules and workspaces. Below is a detailed explanation with diagrams.

---

## 📦 Module Structure in Terraform

Modules allow you to encapsulate and reuse configuration. A typical module is a folder containing `.tf` files (main, variables, outputs).

### 🔧 Module Folder Layout

```
terraform-project/
│
├── main.tf                  # Root module
├── variables.tf             # Root-level variables
├── outputs.tf               # Root-level outputs
├── backend.tf               # Remote backend config
│
├── modules/
│   ├── networking/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── compute/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
```

### 📘 Diagram - Module Structure

```
Root Module
│
├── main.tf
├── variables.tf
├── outputs.tf
│
└── modules/
    ├── networking/  → Creates VNet, Subnets
    └── compute/     → Creates VMs
```

### ✅ Example: Calling a Module (Azure)

```hcl
module "networking" {
  source              = "./modules/networking"
  rg_name             = var.rg_name
  location            = var.location
  vnet_cidr           = "10.0.0.0/16"
  subnet_cidrs        = ["10.0.1.0/24", "10.0.2.0/24"]
}
```

---

## 🌐 Workspace Structure in Terraform

Workspaces help manage multiple environments (e.g., dev, staging, prod) without duplicating code.

### 🧩 Default vs Named Workspaces

* `default`: initial workspace
* Named: `dev`, `prod`, etc.

```bash
terraform workspace new dev
terraform workspace select dev
```

### 🏗️ Workspace Diagram

```
Terraform CLI
│
├── Workspace: dev
│   └── dev.tfstate
│
├── Workspace: prod
│   └── prod.tfstate
```

Each workspace maintains its own `.tfstate` file.

### 📌 Example: Dynamic Naming with Workspace

```hcl
resource "azurerm_resource_group" "example" {
  name     = "myapp-${terraform.workspace}-rg"
  location = var.location
}
```

If you're in the `dev` workspace, the RG name becomes `myapp-dev-rg`.

---

## 💾 Workspaces with Azure Blob Remote Backend

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "tfstateprod"
    container_name       = "tfstate"
    key                  = "${terraform.workspace}.tfstate"
  }
}
```

This ensures each workspace stores a unique state file:

* `dev.tfstate`
* `prod.tfstate`

---

Would you like diagrams as images or ASCII charts? I can also help visualize module interconnections, backend interactions, or even generate PNG/SVG diagrams.

