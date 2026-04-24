# Resources

![Resources](../assets/images/2-Resources-TF.png)

Resources are the heart of Terraform because they represent the infrastructure objects Terraform manages.

## What Is A Resource

A resource is a Terraform block that creates, updates, or deletes an object in a target platform.

Examples:

- Azure resource group
- virtual network
- subnet
- network security group
- VM
- AKS cluster

## General Resource Syntax

```hcl
resource "<resource_type>" "<local_name>" {
  argument_1 = value
  argument_2 = value
}
```

Example:

```hcl
resource "azurerm_resource_group" "example" {
  name     = "rg-demo-dev"
  location = "East US"
}
```

## Parts Of A Resource

- `resource`: block type
- `azurerm_resource_group`: resource type
- `example`: local Terraform name
- inside the braces: arguments

Terraform refers to this object as:

```hcl
azurerm_resource_group.example
```

## Resource Type Vs Resource Name

These are different:

- resource type tells Terraform what kind of object to manage
- local resource name is just the name used inside the Terraform code

Example:

```hcl
resource "azurerm_virtual_network" "hub_vnet" {
  name                = "vnet-hub-dev"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.10.0.0/16"]
}
```

Here:

- resource type is `azurerm_virtual_network`
- local name is `hub_vnet`

## Resource Arguments

Arguments are the settings inside the resource block.

Examples:

- `name`
- `location`
- `resource_group_name`
- `address_space`

Different resources support different arguments.

## Resource Attributes

Attributes are values Terraform can read from a resource after it exists.

Examples:

- `.id`
- `.name`
- `.location`

Example:

```hcl
output "resource_group_id" {
  value = azurerm_resource_group.example.id
}
```

## Referencing One Resource From Another

Terraform automatically understands many dependencies when one resource references another.

Example:

```hcl
resource "azurerm_resource_group" "example" {
  name     = "rg-demo-dev"
  location = "East US"
}

resource "azurerm_virtual_network" "example" {
  name                = "vnet-demo-dev"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
}
```

Because the VNet references the resource group, Terraform knows the resource group must exist first.

## Implicit Dependency

When Terraform detects dependency through references, it is called implicit dependency.

This is the preferred style in most cases.

## Explicit Dependency With `depends_on`

Sometimes Terraform cannot understand the dependency automatically. In that case, use `depends_on`.

Example:

```hcl
resource "azurerm_resource_group" "example" {
  name     = "rg-demo-dev"
  location = "East US"
}

resource "azurerm_storage_account" "example" {
  name                     = "storagedemodev123"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
```

If references already exist, `depends_on` is not needed.

Use `depends_on` only when you truly need it.

## Meta-Arguments

Meta-arguments are special settings Terraform supports for many resources.

Important ones:

- `count`
- `for_each`
- `depends_on`
- `lifecycle`
- `provider`

## `count`

Use `count` when you want multiple similar instances.

Example:

```hcl
resource "azurerm_resource_group" "example" {
  count    = 2
  name     = "rg-demo-${count.index}"
  location = "East US"
}
```

## `for_each`

Use `for_each` when resources have stable names or keys.

Example:

```hcl
resource "azurerm_resource_group" "example" {
  for_each = {
    dev  = "East US"
    test = "West US"
  }

  name     = "rg-${each.key}"
  location = each.value
}
```

In production, `for_each` is often easier to manage than `count`.

## Lifecycle Meta-Argument

`lifecycle` lets you influence how Terraform handles updates and replacement.

Example:

```hcl
resource "azurerm_resource_group" "example" {
  name     = "rg-demo-dev"
  location = "East US"

  lifecycle {
    prevent_destroy = true
  }
}
```

This can help protect critical resources, but it must be used intentionally.

## Real Azure Example: Resource Group, VNet, And Subnet

```hcl
resource "azurerm_resource_group" "network" {
  name     = "rg-network-dev"
  location = "East US"
}

resource "azurerm_virtual_network" "main" {
  name                = "vnet-main-dev"
  location            = azurerm_resource_group.network.location
  resource_group_name = azurerm_resource_group.network.name
  address_space       = ["10.20.0.0/16"]
}

resource "azurerm_subnet" "app" {
  name                 = "snet-app"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.20.1.0/24"]
}
```

This example shows:

- a resource group
- a VNet inside it
- a subnet inside that VNet

## Resource Address

Every Terraform-managed resource has an address.

Examples:

- `azurerm_resource_group.network`
- `azurerm_virtual_network.main`
- `azurerm_subnet.app`

If `for_each` is used, the address includes the key.

Example:

- `azurerm_resource_group.example["dev"]`

## Common Beginner Mistakes With Resources

- confusing Azure resource name with Terraform local name
- hardcoding values everywhere instead of using variables
- overusing `depends_on`
- not understanding when a change will force replacement
- mixing unrelated resources in one large root module

## What To Learn Next

After resources, move to [05-variables-types-outputs-and-locals.md](./05-variables-types-outputs-and-locals.md).
