# Advanced Patterns, Security, Testing, And CI/CD

This file covers the skills that usually move someone from working Terraform knowledge to stronger production knowledge.

## Advanced Terraform Language Patterns

Useful advanced features:

- `for_each`
- `for` expressions
- `locals`
- validation
- `lifecycle`
- `moved` blocks
- `precondition`
- `postcondition`
- provider aliases

## `for` Expressions

These help transform data.

Example:

```hcl
output "upper_names" {
  value = [for name in ["dev", "test"] : upper(name)]
}
```

## Dynamic Blocks

Dynamic blocks are useful when nested blocks must be created programmatically.

Use them carefully because they can make code harder to read.

## `moved` Blocks

Use `moved` blocks when refactoring resource addresses without recreating the real resource.

Example:

```hcl
moved {
  from = azurerm_resource_group.old
  to   = module.platform.azurerm_resource_group.this
}
```

## Preconditions And Postconditions

These allow additional safety checks.

They are useful when:

- certain values must be true before apply
- assumptions should be validated

## Security Practices

## Secret Handling

Good practice:

- avoid raw secrets in code
- prefer identity-based access
- protect state strongly
- mark outputs as sensitive where appropriate

Important reminder:

- `sensitive = true` hides output display in many cases
- it does not magically remove all risk from how data is stored

## Azure Security Practices

- use RBAC carefully
- separate non-production and production access
- use least privilege
- protect backend storage
- prefer managed identity or federated identity for automation

## CI/CD Pattern

A common safe Terraform pipeline:

1. `terraform fmt -check`
2. `terraform validate`
3. linter and security scan
4. `terraform plan`
5. approval
6. `terraform apply`

## Why Plan And Apply Should Be Separate

This improves:

- review quality
- approval control
- production safety

## Useful Tooling Around Terraform

Examples:

- `tflint`
- `tfsec`
- `checkov`
- Terratest

Use the right amount of tooling for your team maturity.

## Testing Strategy

Test at multiple levels:

- formatting
- validation
- static analysis
- module example tests
- integration tests
- recovery drills

## Policy And Guardrails

Mature teams often add guardrails such as:

- policy checks
- naming standards
- tag requirements
- no-public-IP rules
- approved regions only

## Advanced Tips

- prefer `for_each` for stable collections
- keep states small enough to review confidently
- keep shared platform and app states separate
- upgrade providers deliberately
- avoid `-target` except for careful recovery work
- never approve a plan you do not understand

## What Advanced Terraform Looks Like

Advanced Terraform usually has:

- reusable modules
- strong state design
- predictable CI/CD
- tested recovery paths
- review discipline
- clear platform ownership
