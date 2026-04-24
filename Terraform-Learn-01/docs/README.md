# Terraform Docs Hub

This folder is now organized as a guided Terraform course from beginner to expert, using Azure as the main real-world example.

The sequence below is designed so that you learn concepts in the same order most people need them:

1. understand what Terraform is
2. learn providers
3. learn resources
4. learn variables and types
5. learn state and backends
6. learn provisioners and lifecycle
7. learn modules and folder structure
8. learn data sources and import
9. learn Azure real-world design
10. learn backup, recovery, and troubleshooting
11. learn advanced patterns and interview prep

## Beginner To Expert Reading Order

1. [01-learning-roadmap.md](./01-learning-roadmap.md)
2. [02-terraform-fundamentals.md](./02-terraform-fundamentals.md)
3. [03-providers.md](./03-providers.md)
4. [04-resources.md](./04-resources.md)
5. [05-variables-types-outputs-and-locals.md](./05-variables-types-outputs-and-locals.md)
6. [06-state-backends-locking-and-workspaces.md](./06-state-backends-locking-and-workspaces.md)
7. [07-provisioners-and-dependency-handling.md](./07-provisioners-and-dependency-handling.md)
8. [08-modules-and-folder-structure.md](./08-modules-and-folder-structure.md)
9. [09-data-sources-import-and-brownfield.md](./09-data-sources-import-and-brownfield.md)
10. [10-azure-real-world-terraform.md](./10-azure-real-world-terraform.md)
11. [11-backups-restore-and-disaster-recovery.md](./11-backups-restore-and-disaster-recovery.md)
12. [12-breaking-scenarios-drift-and-troubleshooting.md](./12-breaking-scenarios-drift-and-troubleshooting.md)
13. [13-advanced-patterns-security-testing-and-ci-cd.md](./13-advanced-patterns-security-testing-and-ci-cd.md)
14. [14-interview-questions.md](./14-interview-questions.md)
15. [15-quick-revision.md](./15-quick-revision.md)
16. [16-commands-reference.md](./16-commands-reference.md)

## Image-Based Concept Flow

The image sequence in `../assets/images/` now lines up with the main learning path:

- `1-Providers-TF.png` -> [03-providers.md](./03-providers.md)
- `2-Resources-TF.png` -> [02-terraform-fundamentals.md](./02-terraform-fundamentals.md) and [04-resources.md](./04-resources.md)
- `3-Variables-TF.png` -> [05-variables-types-outputs-and-locals.md](./05-variables-types-outputs-and-locals.md)
- `4-Statefile-TF.png` -> [06-state-backends-locking-and-workspaces.md](./06-state-backends-locking-and-workspaces.md)
- `5-Provisioners-TF.png` and `5-a-Provisioners-TF.png` -> [07-provisioners-and-dependency-handling.md](./07-provisioners-and-dependency-handling.md)
- `6-Restore-statefile-TF.png` -> [11-backups-restore-and-disaster-recovery.md](./11-backups-restore-and-disaster-recovery.md)
- `7-Modules-TF.png` -> [08-modules-and-folder-structure.md](./08-modules-and-folder-structure.md)
- `8-DataSource-TF.png` and `8-a-DATA-sources-TF.png` -> [09-data-sources-import-and-brownfield.md](./09-data-sources-import-and-brownfield.md)
- `9-Locals-TF.png` -> [05-variables-types-outputs-and-locals.md](./05-variables-types-outputs-and-locals.md)
- `10-workspaces-TF.png` -> [06-state-backends-locking-and-workspaces.md](./06-state-backends-locking-and-workspaces.md)

## What Was Cleaned Up

To make the docs easier for a beginner:

- duplicate and overlapping note files were merged into clearer guided lessons
- the non-Terraform bash notes were removed from the docs path
- import, study, and concept notes were consolidated into the new numbered flow
- commands were moved into one final reference page

## How To Study Effectively

Best learning loop:

1. read one doc
2. open one matching example under `../examples/`
3. run `terraform fmt`, `terraform validate`, and `terraform plan`
4. explain the concept back in your own words
5. write a tiny example from memory

## If You Are Completely New

Start with:

1. [01-learning-roadmap.md](./01-learning-roadmap.md)
2. [02-terraform-fundamentals.md](./02-terraform-fundamentals.md)
3. [03-providers.md](./03-providers.md)
4. [04-resources.md](./04-resources.md)
5. [05-variables-types-outputs-and-locals.md](./05-variables-types-outputs-and-locals.md)

Do not jump straight to advanced topics until these feel comfortable.
