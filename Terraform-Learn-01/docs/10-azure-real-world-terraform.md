# Azure Real-World Terraform

Terraform syntax is only one part of becoming strong. Real skill comes from designing safe, maintainable Azure environments.

## Common Azure Resources Managed With Terraform

Teams often manage:

- resource groups
- VNets and subnets
- NSGs and route tables
- storage accounts
- managed disks and snapshots
- virtual machines
- load balancers
- private endpoints and DNS
- Key Vault
- AKS
- Log Analytics
- App Service

## Real-World Layering

A strong Azure Terraform design often separates layers like this:

- bootstrap
- shared platform
- application infrastructure
- operational tooling

### Bootstrap

Contains:

- Terraform backend storage
- baseline identities
- foundational access configuration

### Shared platform

Contains:

- shared network
- shared DNS
- monitoring
- logging
- shared Key Vault or platform services

### Application infrastructure

Contains:

- app-specific resource groups
- compute
- storage
- app networking
- app identities

### Operations

Contains:

- alerts
- backup policy
- automation

## Naming In Azure

Azure naming matters because:

- some resources must be globally unique
- some names have length limits
- environments need to be distinguishable

Example naming logic:

```hcl
locals {
  app         = "payments"
  environment = "dev"
  region      = "eus"
  prefix      = "${local.app}-${local.environment}-${local.region}"
}
```

## Tagging In Azure

Tags help with:

- cost tracking
- ownership
- audit and governance
- incident response

Example:

```hcl
locals {
  common_tags = {
    environment = "dev"
    owner       = "platform-team"
    managed_by  = "terraform"
    application = "payments"
  }
}
```

## Real-Life Scenario 1: Small Team, One Application

A small Azure app may start with:

- one resource group
- one VNet
- one subnet
- one VM or App Service
- one storage account

This can live in one state at first if the environment is still small.

## Real-Life Scenario 2: Shared Network, Multiple Apps

As complexity grows, one shared VNet should not be in the same state as every application.

Better split:

- network state
- shared observability state
- one state per application stack

## Real-Life Scenario 3: AKS Platform

A realistic AKS setup may include:

- resource group
- AKS cluster
- node pools
- Log Analytics
- managed identity
- ingress or networking integration

Best practice:

- keep the AKS platform state separate from the workloads deployed into the cluster

## Real-Life Scenario 4: Multi-Environment Azure Layout

Example:

```text
live/
  dev/
    network/
    platform/
    payments-app/
  prod/
    network/
    platform/
    payments-app/
```

This is often easier to understand than using one huge root module with many `if`-style variations.

## Real-Life Scenario 5: Existing Azure Environment

Most companies already have Azure resources before Terraform arrives.

Terraform adoption approach:

1. discover existing resources
2. choose state boundaries
3. create matching code
4. import gradually
5. validate plans carefully

## Subscription Design

Large organizations may separate:

- dev subscription
- prod subscription
- shared services subscription
- security or monitoring subscription

Terraform must handle this carefully using:

- separate root modules
- provider aliases where needed
- clear ownership boundaries

## State Boundaries In Azure

Good reasons to split state:

- different owners
- different release frequency
- different blast radius
- shared infrastructure versus app infrastructure

Bad reason:

- splitting for no reason other than too many files

## Azure Best Practices For Beginners To Learn Early

- keep backend bootstrap separate
- pin provider versions
- use tags consistently
- avoid manual portal changes
- separate shared platform and application states
- read every plan before apply

## Common Azure Anti-Patterns

- one giant state for all subscriptions
- shared network in the same state as one application
- hardcoded secrets in Terraform files
- manual changes in portal without reconciling code
- naming that changes often and forces replacement

## Expert Mindset In Azure

Before applying Terraform in Azure, ask:

- what is the blast radius
- is this a shared resource
- does this change force replacement
- is state separation correct
- what is the rollback or recovery plan
