# Breaking Scenarios, Drift, And Troubleshooting

Real Terraform skill shows up when something goes wrong. This file covers the most common high-risk situations.

## What Makes A Change Dangerous

A Terraform change is dangerous when it may:

- force replacement of a critical resource
- destroy a shared dependency
- break state tracking
- increase drift
- leave infrastructure partially updated

## Scenario 1: Changing A Name That Forces Replacement

Some Azure resources cannot be safely renamed in place.

Examples:

- storage accounts
- some networking-related names

If the plan shows destroy and create, stop and assess the impact before applying.

## Scenario 2: Changing `for_each` Keys

If a key changes:

- Terraform thinks it is a new instance

That can mean:

- destroy old
- create new

Use stable keys and plan refactors carefully.

## Scenario 3: Moving From `count` To `for_each`

This changes resource addresses.

Safe approaches:

- use `moved` blocks
- or use `terraform state mv`

Do not casually do this in production without planning.

## Scenario 4: Moving Resources Into A Module

Terraform may think:

- old resource disappeared
- new resource appeared

Use:

- `moved` blocks
- state migration

Then validate using `terraform plan`.

## Scenario 5: Manual Portal Changes

This is drift.

Examples:

- tags changed in the Azure portal
- NSG rules edited manually
- subnet configuration changed outside Terraform

Response:

1. detect with `terraform plan`
2. decide whether code or real infrastructure should win
3. reconcile intentionally

## Scenario 6: Partial Apply Failure

This happens when Terraform creates some resources and fails before finishing.

Possible causes:

- Azure API errors
- RBAC issues
- quota limits
- naming conflicts
- policy blocks

Response:

1. do not rerun blindly
2. inspect Azure
3. inspect state
4. run `terraform plan`
5. reconcile the real situation first

## Scenario 7: Wrong Backend Or Wrong Workspace

Symptoms:

- Terraform suddenly wants to create everything again
- Terraform shows an unexpectedly huge plan

Before doing anything:

- verify backend key
- verify workspace
- verify subscription
- verify credentials

## Scenario 8: Provider Upgrade Surprise

Provider upgrades can change behavior.

Good practice:

- pin versions
- upgrade deliberately
- review plan carefully after upgrades

## Scenario 9: Shared Resource In Wrong State

This is a design problem.

Example:

- a shared VNet is managed in an app-owned state

Risk:

- app changes may affect shared platform resources

Fix:

- separate state by ownership and blast radius

## Scenario 10: Network CIDR Changes

Network changes can be disruptive because many resources may depend on the subnet or VNet.

Do not treat them like small edits.

Treat them like migrations.

## Drift Investigation Flow

Use this whenever a plan looks suspicious:

1. inspect the plan
2. identify which resources changed
3. confirm whether the change came from code or from the real environment
4. inspect Azure manually if needed
5. decide whether to update code, import, or restore the environment

## Troubleshooting Commands

```bash
terraform validate
terraform plan
terraform show
terraform state list
terraform state show <resource_address>
terraform graph
```

## Troubleshooting Mindset

When something looks wrong:

- stop
- inspect
- compare code, state, and real Azure
- avoid panic applies

## Strong Prevention Habits

- read every plan
- keep state boundaries clean
- avoid manual portal changes
- use `moved` blocks during refactors
- pin providers
- document ownership of shared resources
