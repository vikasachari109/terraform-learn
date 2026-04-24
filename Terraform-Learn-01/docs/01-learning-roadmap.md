# Terraform Learning Roadmap

This roadmap is written for someone who is starting from scratch and wants to grow into a strong Terraform engineer.

## Goal

The goal is not just to memorize commands. The goal is to understand:

- what Terraform is doing
- why plans change
- how Azure infrastructure should be structured
- how to recover when something goes wrong
- how to write Terraform safely for teams

## Stage 1: Beginner Foundation

At this stage, focus on understanding the language and workflow.

Read in this order:

1. [02-terraform-fundamentals.md](./02-terraform-fundamentals.md)
2. [03-providers.md](./03-providers.md)
3. [04-resources.md](./04-resources.md)
4. [05-variables-types-outputs-and-locals.md](./05-variables-types-outputs-and-locals.md)

What you should learn:

- what Terraform is
- declarative IaC
- provider blocks
- resource blocks
- variable blocks
- outputs and locals
- how to run `init`, `fmt`, `validate`, `plan`, and `apply`

## Stage 2: Working Practitioner

At this stage, focus on how Terraform behaves in real projects.

Read in this order:

1. [06-state-backends-locking-and-workspaces.md](./06-state-backends-locking-and-workspaces.md)
2. [07-provisioners-and-dependency-handling.md](./07-provisioners-and-dependency-handling.md)
3. [08-modules-and-folder-structure.md](./08-modules-and-folder-structure.md)
4. [09-data-sources-import-and-brownfield.md](./09-data-sources-import-and-brownfield.md)

What you should learn:

- how state works
- why remote backends matter
- when workspaces help and when they do not
- module basics
- import basics
- data sources
- refactoring safely

## Stage 3: Azure Real-World Design

At this stage, focus on platform thinking.

Read:

1. [10-azure-real-world-terraform.md](./10-azure-real-world-terraform.md)
2. [11-backups-restore-and-disaster-recovery.md](./11-backups-restore-and-disaster-recovery.md)
3. [12-breaking-scenarios-drift-and-troubleshooting.md](./12-breaking-scenarios-drift-and-troubleshooting.md)

What you should learn:

- Azure naming and tagging
- state separation by blast radius
- backend bootstrap
- brownfield adoption
- backup and recovery thinking
- drift handling
- dangerous change recognition

## Stage 4: Advanced And Interview Ready

At this stage, focus on operational maturity.

Read:

1. [13-advanced-patterns-security-testing-and-ci-cd.md](./13-advanced-patterns-security-testing-and-ci-cd.md)
2. [14-interview-questions.md](./14-interview-questions.md)
3. [15-quick-revision.md](./15-quick-revision.md)
4. [16-commands-reference.md](./16-commands-reference.md)

What you should learn:

- advanced Terraform patterns
- secure pipeline habits
- testing and validation
- production review mindset
- clear interview answers

## Practical 8-Week Plan

### Weeks 1-2

- read the beginner docs
- run small Terraform examples locally
- understand provider, resource, variable, and output basics

### Weeks 3-4

- provision simple Azure resources
- practice `terraform plan` reading
- learn state basics and remote backend concepts

### Weeks 5-6

- build or study reusable modules
- practice data sources and import
- separate shared and app-specific design mentally

### Weeks 7-8

- study drift, failure, backup, and recovery docs
- answer interview questions aloud
- practice reviewing plans for destructive risk

## Strong Habits To Build Early

- read every plan before apply
- keep Terraform code in Git
- avoid manual portal changes
- write notes on every forced replacement you see
- learn one state-related command each week

## Signs You Are Improving

- You can explain what each block does without guessing.
- You can tell when a change is risky before applying it.
- You understand when to use a module and when not to.
- You know the difference between a data source and an imported resource.
- You think about backup and recovery, not only provisioning.
