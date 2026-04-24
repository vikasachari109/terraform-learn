# Terraform Data Types And Expressions

This page collects clean examples for common variable types and looping patterns.

## Basic Variable With Validation

```hcl
variable "environment" {
  type        = string
  description = "Deployment environment"

  validation {
    condition     = contains(["dev", "test", "stage"], var.environment)
    error_message = "Allowed values are dev, test, and stage."
  }
}
```

## List

```hcl
variable "prefixes" {
  type    = list(string)
  default = ["Mr", "Mrs", "Sir"]
}
```

Use a list when order matters and duplicate values are acceptable.

## Set

```hcl
variable "regions" {
  type    = set(string)
  default = ["eastus", "westus"]
}
```

Use a set when duplicate values should be removed automatically.

## Map

```hcl
variable "resource_groups" {
  type = map(string)
  default = {
    dev   = "East US"
    test  = "West US"
    stage = "South Central US"
  }
}
```

## Object

```hcl
variable "vm_profile" {
  type = object({
    name    = string
    size    = string
    zone    = number
    tags    = map(string)
    enabled = bool
  })
}
```

## Tuple

```hcl
variable "sample_tuple" {
  type    = tuple([string, number, bool])
  default = ["vm-app", 2, true]
}
```

## `count`

Use `count` when resources are almost identical and can be indexed numerically.

```hcl
variable "vm_names" {
  type    = list(string)
  default = ["vm1", "vm2", "vm3"]
}

resource "azurerm_virtual_machine" "vm" {
  count = length(var.vm_names)
  name  = var.vm_names[count.index]
}
```

## `for_each`

Use `for_each` when resources should be keyed by name instead of number.

```hcl
resource "azurerm_resource_group" "rg" {
  for_each = var.resource_groups

  name     = each.key
  location = each.value
}
```

## `for` Expressions

Transform a list:

```hcl
output "uppercase_names" {
  value = [for name in ["alice", "bob", "charlie"] : upper(name)]
}
```

Transform a list into a map:

```hcl
output "vm_map" {
  value = {
    for idx, name in ["vm1", "vm2", "vm3"] :
    name => "vm-${idx + 1}"
  }
}
```

## Validation Example

```hcl
variable "storage_account_name" {
  type = string

  validation {
    condition     = length(var.storage_account_name) >= 3 && length(var.storage_account_name) <= 24
    error_message = "Storage account name must be between 3 and 24 characters."
  }
}
```

## Rule Of Thumb

- `list`: ordered values
- `set`: unique unordered values
- `map`: key/value lookup
- `object`: named fields with fixed types
- `tuple`: fixed position with mixed types
