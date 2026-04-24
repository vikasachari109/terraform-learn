# Terraform Interview Questions

This file is designed for real interviews, not just quick revision.

The old version gave short answers. This version goes one level deeper so you can handle follow-up questions like:

- "How did you do that in your project?"
- "What were the actual steps?"
- "Why did you choose that approach?"
- "What could go wrong?"

## Best Way To Answer In An Interview

A strong Terraform answer usually has four parts:

1. definition
2. why it matters
3. how you implemented it
4. risk or tradeoff

Use this pattern:

```text
Short answer:
Terraform state stores Terraform's mapping of configuration to real resources.

Why it matters:
Without correct state, plans become unsafe and Terraform may try to recreate or destroy the wrong things.

How I handle it:
I keep state in a remote backend, use locking, review plan output carefully, and split state by ownership and blast radius.

Tradeoff:
State becomes a critical operational asset, so backend access and recovery procedures must be handled carefully.
```

## Fundamentals

### 1. What is Terraform

Terraform is an Infrastructure as Code tool that lets us define infrastructure in code, review the intended changes, and apply them in a controlled way.

Why it matters:

- infrastructure becomes repeatable
- changes can be reviewed before execution
- environments become easier to recreate

If the interviewer asks, "How have you used it?":

You can answer:

"I used Terraform to provision Azure resource groups, VNets, subnets, NSGs, storage accounts, and AKS-related infrastructure. My normal workflow was to write the configuration, run `terraform fmt`, `terraform validate`, and `terraform plan`, review the output, and then apply only after I understood the blast radius."

### 2. What does declarative mean in Terraform

Terraform is declarative because we describe the end state we want, and Terraform determines the sequence of actions required to reach that state.

Example:

- we declare a VNet, subnet, and NSG
- Terraform figures out the dependency order automatically

If asked, "Why is that better than scripts?":

You can say:

"With scripts, I usually have to manage order and logic manually. With Terraform, the dependency graph and plan output make the changes easier to reason about and review."

### 3. What is a provider

A provider is the plugin Terraform uses to interact with a platform such as Azure.

Example:

- `azurerm` for Azure resources
- `azuread` for Entra ID objects
- `azapi` for Azure features not yet fully covered by AzureRM

How I explain implementation:

"In real projects I pin provider versions in the `required_providers` block, initialize them with `terraform init`, and keep provider configuration in the root module so that authentication and subscription handling stay explicit."

### 4. What is a resource

A resource is a Terraform block that creates or manages a real infrastructure object.

Example:

```hcl
resource "azurerm_resource_group" "example" {
  name     = "rg-demo-dev"
  location = "East US"
}
```

If asked, "How do resources relate to each other?":

You can say:

"Terraform builds a dependency graph. If one resource references another, like a subnet referencing a VNet, Terraform understands the creation order automatically."

### 5. What is a data source

A data source reads information from infrastructure that already exists instead of creating it.

How I explain the difference in practice:

"If another team owns a shared VNet and my application only needs the subnet ID, I use a data source or a module output instead of trying to manage that shared network from my application state."

### 6. What is Terraform state

Terraform state is Terraform's record of the resources it manages and how those resources map to real infrastructure.

Why it matters:

- Terraform uses it to know what already exists
- it allows change detection
- it prevents Terraform from acting like every run is a first-time creation

How I manage it:

1. store it remotely
2. protect backend access
3. use locking
4. avoid manual edits
5. back it up before state surgery

### 7. Why should Terraform state not be committed to Git

State changes frequently, may contain sensitive infrastructure details, and is not a safe collaboration mechanism.

What I would say in an interview:

"For team environments, I keep state in a remote backend such as Azure Storage. That gives centralization and safer collaboration, and it reduces the risks that come with local files being deleted or copied around."

### 8. What is a backend

A backend tells Terraform where state is stored and how backend operations are handled.

How I explain it:

"In Azure, I usually use an Azure Storage backend with a dedicated resource group, storage account, blob container, and a clear state key. I keep that backend bootstrap separate from application states so the backend doesn't depend on itself."

### 9. What is a module

A module is a Terraform configuration folder. The folder where Terraform runs is the root module, and reusable called modules are child modules.

How I explain real usage:

"I use child modules for repeated building blocks like resource groups, VNets, monitoring, or AKS. I keep the provider configuration in the root module and expose only clean inputs and outputs from the child module."

### 10. What is the difference between `plan` and `apply`

`plan` previews changes. `apply` executes them.

If the interviewer asks, "How do you use that in a team?":

You can say:

"In a team workflow, I separate plan and apply. The plan is reviewed first, especially for destructive changes, and only then do we apply. That creates a safer approval step."

### 11. What is idempotency in Terraform

It means running the same configuration repeatedly should not create duplicate infrastructure if nothing actually changed.

Why it matters:

- it makes automation reliable
- it reduces accidental duplication

### 12. What is drift

Drift means the real infrastructure changed outside Terraform, so Terraform code and the live environment no longer match.

How I handle it:

1. run `terraform plan`
2. inspect what changed
3. decide whether code or live infrastructure should be the source of truth
4. reconcile intentionally

## This Vs That

### 13. Resource vs Data Source

Resource creates or manages. Data source reads.

Real answer:

"I use resources for infrastructure Terraform owns. I use data sources when the infrastructure already exists or is owned by another team. That separation avoids accidental ownership confusion."

### 14. Root Module vs Child Module

Root module is where Terraform runs. Child module is reused by another module.

How I explain usage:

"The root module is where I keep environment-specific wiring, like subscription, region, backend, and module calls. The child module contains reusable logic."

### 15. Local State vs Remote State

Local state is stored on disk and is acceptable for small personal learning. Remote state is better for teams because it improves collaboration, locking, and recovery.

How I describe my steps:

1. bootstrap backend resources
2. configure backend block
3. initialize with `terraform init`
4. verify the correct key and environment
5. keep backend access tightly controlled

### 16. `count` vs `for_each`

`count` uses numeric indexes. `for_each` uses stable keys.

What I say in interviews:

"I prefer `for_each` for named resources because the addresses are clearer and refactors are safer. I use `count` mostly when the objects are nearly identical and naturally indexed."

### 17. Variable vs Local

Variable is input from outside. Local is a calculated value inside the module.

How I explain design:

"I use variables for things the caller should control, like location or environment. I use locals for naming, tag maps, and derived values that should stay internal."

### 18. Output vs Local

Output is exposed outside the module. Local stays inside.

Why this matters:

"Outputs become part of the integration contract. So I keep them clean and intentional. Locals are just helpers inside the module."

### 19. Implicit Dependency vs Explicit Dependency

Implicit dependency comes from references. Explicit dependency uses `depends_on`.

What I say:

"I prefer implicit dependencies because they make the graph more natural. I use `depends_on` only when Terraform cannot infer the dependency from references."

### 20. `terraform import` vs `import` block

Both bring existing infrastructure into Terraform state. CLI import is manual. Import blocks are configuration-based and can stay in code as documentation.

How I would do it:

1. write the resource block first
2. import the resource
3. run `terraform plan`
4. fix mismatches until the plan is understood

### 21. `moved` block vs `terraform state mv`

Both preserve identity during refactors. `moved` is code-based and great for repeatable refactors. `state mv` is a CLI operation used during migration or state surgery.

What I say in interviews:

"If I am refactoring code in a way that should be repeatable and understandable for future maintainers, I prefer `moved` blocks. If I need state surgery in an already existing environment, `terraform state mv` can help."

### 22. Workspace vs Separate Environment Folders

Workspaces are separate states in the same working directory. Separate folders or root modules usually provide clearer environment boundaries for real production.

How I explain my choice:

"For small demos, workspaces are okay. For serious dev, test, and prod environments, I usually prefer separate environment folders because access, pipelines, and state ownership become clearer."

### 23. AzureRM vs AzAPI

AzureRM is the main provider for stable Azure resources. AzAPI is useful when AzureRM does not yet support a required feature or resource type.

How I decide:

1. check whether AzureRM supports the resource or feature
2. if not, evaluate AzAPI
3. keep AzAPI usage narrow and documented
4. validate the state and module design around it

### 24. Service Principal vs Managed Identity

Both can authenticate Terraform to Azure. Service principals are common for automation. Managed identity is often safer for Azure-hosted automation because it reduces secret handling.

How I choose:

- local dev: Azure CLI or approved local auth path
- external CI system: usually service principal or OIDC-style workflow
- Azure-hosted automation: managed identity is often a strong option

### 25. CLI Authentication vs Non-Interactive Authentication

CLI login is convenient for local development. Non-interactive authentication is required for pipelines.

What I say:

"I never design a production pipeline around interactive login. For pipelines I use service principal, managed identity, or the platform-approved non-interactive path."

### 26. `terraform.tfvars` vs `*.auto.tfvars`

Both provide variable values. `terraform.tfvars` is the standard default file. `*.auto.tfvars` files are also automatically loaded and can help with structured environment conventions.

### 27. `prevent_destroy` vs `create_before_destroy`

`prevent_destroy` protects against accidental destruction. `create_before_destroy` attempts to create the replacement first.

How I use them:

"I use `prevent_destroy` only on very critical resources and only with clear team understanding. I use `create_before_destroy` when replacement is expected and lower downtime is important."

### 28. Drift vs Planned Change

Drift is an outside change. Planned change comes from intentional Terraform code or input updates.

## Advantages And Disadvantages

### 29. What are the advantages of Terraform

Main advantages:

- reusable code
- previewable plans
- repeatable environments
- automation support
- cross-provider model

How I expand this in an interview:

"The biggest practical advantage is not just automation. It is controlled change. The plan output forces a review step, which is one of the strongest safety features in real teams."

### 30. What are Terraform's disadvantages or limitations

Main limitations:

- state must be managed carefully
- poor design can create huge blast radius
- not a full backup or DR tool
- not ideal for every in-guest configuration problem

Good interview phrasing:

"Terraform is powerful, but it is not magic. If the state model, ownership boundaries, and recovery process are weak, Terraform can amplify mistakes very quickly."

### 31. Advantages of remote state

- better collaboration
- central source of truth
- safer operational model
- locking support

### 32. Disadvantages of local state

- hard to share safely
- easy to lose
- weak recovery story
- poor fit for production teamwork

### 33. Advantages of modules

- reuse
- standardization
- cleaner environment code
- easier onboarding

How I explain real usage:

"Modules help teams standardize things like naming, tags, monitoring, and baseline policies, instead of copying the same code everywhere."

### 34. Disadvantages of badly designed modules

- hidden complexity
- weak reuse
- unclear ownership
- painful upgrades

### 35. Advantages of `for_each`

- stable keys
- clearer addresses
- better readability for named resources

### 36. Disadvantages of `for_each`

- key changes can be destructive
- data transformations can be slightly harder for beginners

### 37. Advantages of managed identity on Azure

- reduced secret handling
- strong fit for Azure-hosted automation
- less credential sprawl

### 38. Tradeoffs of managed identity

- depends on runtime location
- may need additional design for cross-environment access
- local developer use is different from Azure-hosted automation

### 39. Advantages of AzAPI

- access to new Azure features
- broader control plane coverage
- useful for unsupported or preview resources

### 40. Tradeoffs of AzAPI

- often lower-level than AzureRM
- less beginner-friendly
- should be used intentionally, not everywhere by default

## Scenario-Based Questions

### 41. A plan shows production subnet replacement. What do you do

I do not apply immediately. A subnet replacement can affect many dependent resources.

My steps:

1. inspect the exact reason for replacement
2. identify dependent resources such as NICs, VMs, private endpoints, or AKS nodes
3. assess whether this is a rename, CIDR change, or refactor issue
4. decide whether the right path is migration, rollback, or redesign
5. only proceed after there is a safe plan

Strong interview phrasing:

"I would treat subnet replacement as a migration event, not a normal change."

### 42. A plan suddenly wants to recreate almost everything. What do you check first

I first assume a state or environment mismatch until proven otherwise.

My steps:

1. verify backend configuration
2. verify workspace
3. verify Azure subscription and credentials
4. verify provider version changes
5. inspect whether resources were moved, imported, or renamed recently

### 43. Someone changed an NSG rule manually in Azure. What now

That is drift.

My response:

1. run `terraform plan`
2. compare Terraform code with the live Azure change
3. decide which one is the intended source of truth
4. either update code or revert the manual change
5. rerun plan before applying anything

### 44. You need to move a resource into a module without recreating it. How do you do it

My preferred approach:

1. refactor the code into the module
2. add a `moved` block when appropriate
3. or use `terraform state mv` carefully
4. run `terraform plan`
5. confirm Terraform no longer wants to destroy and recreate

### 45. How would you adopt Terraform in a brownfield Azure environment

I would do it gradually.

Steps:

1. inventory existing resources
2. choose state boundaries based on ownership and blast radius
3. write matching Terraform code
4. import resources in manageable groups
5. review plans after each import
6. avoid giant all-at-once migrations

### 46. Your team wants one giant state for all Azure resources. Do you agree

No.

Why:

- blast radius becomes huge
- plans become hard to review
- teams block each other
- shared and app-specific ownership gets mixed

What I would propose:

- split state by ownership
- split by lifecycle
- split by deployment cadence
- keep shared platform resources separate from applications

### 47. Would you use workspaces or separate folders for dev and prod

For serious environments, I usually prefer separate folders or root modules.

Why:

- clearer access control
- clearer pipeline separation
- lower risk of applying to the wrong environment

### 48. A developer used `-target` for a quick fix. What is your view

`-target` can help in narrow recovery or debugging scenarios, but it should not become the default deployment approach.

Why:

- it may skip parts of the normal dependency picture
- it can create misleading confidence
- it encourages partial workflows instead of consistent ones

### 49. A Terraform apply failed halfway. What do you do next

I do not immediately rerun.

My steps:

1. inspect Azure for partially created resources
2. inspect state
3. run `terraform plan`
4. identify whether the failure was due to RBAC, quota, naming, API error, or another issue
5. reconcile the actual environment first

### 50. A storage account name must change. How do you think about it

I assume that change may force replacement and treat it as a migration problem.

My steps:

1. confirm whether the name change forces recreation
2. assess whether data exists and how it is used
3. plan migration or cutover
4. define rollback path
5. apply only during a controlled change window if needed

### 51. AzureRM does not support the feature you need. What do you do

I evaluate AzAPI, but I use it deliberately.

My steps:

1. confirm the feature gap
2. check whether AzAPI supports the needed resource type or API version
3. keep the AzAPI usage as small and focused as possible
4. document why it is used
5. continue validating state and lifecycle behavior

### 52. Another team owns the shared VNet, but your app needs its subnet ID. What do you do

I avoid taking ownership of the shared network from the app stack.

My options:

- use a data source
- use a trusted output from the shared platform stack
- use a documented cross-stack interface

## Recovery Questions

### 53. What would you do if state is locked

I first confirm whether a real Terraform run is still active.

My steps:

1. check CI/CD pipeline history
2. check whether another engineer is running apply
3. confirm the lock is stale
4. only then consider `terraform force-unlock`

### 54. What would you do if the wrong backend key was configured

I would stop immediately.

My steps:

1. confirm the intended backend key and state location
2. compare with current backend configuration
3. fix the configuration
4. reinitialize safely
5. do not apply until I know I am looking at the right state

### 55. What would you do if someone deleted a Terraform-managed resource manually

I would first assess the actual impact.

Steps:

1. identify what was deleted
2. determine whether data or downstream dependencies were affected
3. decide whether to restore, recreate, or import a replacement
4. reconcile Terraform state afterward

### 56. What would you do if drift is detected in production

I would investigate before fixing.

Steps:

1. identify drift with `terraform plan`
2. inspect the real Azure state
3. determine whether the live change was intentional
4. update code or restore the environment
5. rerun plan before apply

### 57. How would you recover after a bad refactor changed resource addresses

I would preserve resource identity instead of recreating infrastructure.

Steps:

1. back up state
2. use `moved` blocks or `terraform state mv`
3. run `terraform plan`
4. confirm no unintended destroy remains

### 58. What if `terraform plan` is clean but the application is still broken

That means infrastructure and application health must be separated in your thinking.

I would inspect:

- application configuration
- secret retrieval
- DNS
- connectivity
- load balancer or ingress path
- database or dependency availability

### 59. What if the backend storage account is unreachable

I would treat that as an operational incident.

Steps:

1. stop risky changes
2. verify network path and access
3. verify storage account health and policy
4. confirm whether the issue is auth, networking, or platform-level
5. resume only after backend health is understood

### 60. How would you think about restoring a Terraform-managed environment after a major outage

I separate recovery into four parts:

1. code
2. state
3. infrastructure
4. application data

Strong answer:

"Terraform helps rebuild infrastructure, but the full restore process still depends on backups, data recovery, and service-specific runbooks."

### 61. Why is Terraform not a full disaster recovery solution

Because it can recreate infrastructure definitions, but it does not automatically restore application data, VM file systems, or complete service state.

## Azure Cloud-Based Questions

### 62. Which Terraform providers are commonly used on Azure

The common ones are:

- AzureRM for most stable Azure infrastructure
- AzureAD for Entra ID-related objects
- AzAPI for newer or unsupported Azure features

### 63. Why is Azure Storage commonly used for Terraform remote state

Because it provides centralized state storage and fits Azure team workflows better than local files.

How I would implement it:

1. create dedicated backend resources
2. create private blob container
3. configure backend block
4. secure access
5. initialize with `terraform init`

### 64. What does a typical Azure remote backend need

- resource group
- storage account
- blob container
- key for the state file

### 65. How would you secure Terraform state in Azure

My approach:

1. dedicate the backend resources
2. use least-privilege access
3. keep the container private
4. restrict network access where practical
5. monitor backend access

### 66. How would you authenticate Terraform in an Azure pipeline

I prefer a non-interactive approach such as service principal, managed identity, or the approved identity model for the platform.

How I choose:

- if the runner is Azure-hosted, managed identity can be strong
- if the runner is external, service principal or another approved automation identity is more common

### 67. When is managed identity especially useful with Terraform on Azure

When automation runs inside Azure and we want to reduce long-lived secret handling.

### 68. What is a common Azure naming challenge in Terraform

Some resources, such as storage accounts, must be globally unique and also follow strict name rules, so naming standards matter a lot.

### 69. How do you usually structure Terraform across Azure subscriptions

I usually keep separate roots or states per subscription or environment, and use provider aliases only when cross-subscription access is actually needed.

### 70. Why should shared networking and app resources usually be in separate states on Azure

Because shared networking has wider blast radius and different ownership, so application changes should not risk shared platform outages.

### 71. When would you use AzAPI with AzureRM

When AzureRM does not yet support the required Azure capability but I still want Terraform to manage it.

### 72. What is one good Azure tagging practice

Standardize tags for environment, owner, application, and managed-by so cost, governance, and troubleshooting are easier.

## Advanced And Interesting Questions

### 73. Why can some data sources be read during apply instead of plan

If a data source depends on values Terraform does not know during planning, Terraform may defer reading it until apply.

### 74. Why is `ignore_changes` risky if overused

Because it can hide important drift and weaken the reliability of your plans.

### 75. Why is provider version pinning important

Because it keeps behavior predictable and reduces surprise changes across machines and pipelines.

### 76. Why do beginners overuse `depends_on`

Because they do not always trust Terraform's dependency graph yet. In many cases, references already create the correct dependency automatically.

### 77. What is the risk of changing `for_each` keys

Terraform may interpret the change as destroying one instance and creating another.

### 78. When would you keep an `import` block in code after the import is done

When you want a record of how the resource entered Terraform management for future maintainers.

### 79. Why is reading a plan a skill, not just a command

Because the real skill is interpreting replacement risk, dependency impact, and blast radius, not just generating the output.

### 80. What is one sign of Terraform maturity in a team

The team understands state boundaries, reviews plans seriously, and has recovery procedures for backend, drift, and failed applies.

### 81. Why can syntactically valid Terraform still be dangerous

Because safe Terraform depends on architecture, ownership boundaries, state design, and recovery discipline, not just syntax.

### 82. Why should you explain tradeoffs in interview answers

Because strong Terraform engineering is based on context. The best answer often depends on scale, ownership, environment, and blast radius.

## Quick Strong Answers

### 83. When is `for_each` better than `count`

When resources have stable names or keys.

### 84. When is remote state better than local state

For any team-based, shared, or important environment.

### 85. When is a module better than copy-paste

When the same pattern will be reused across environments or teams.

### 86. When is a data source better than import

When Terraform only needs to read the object, not manage its lifecycle.

### 87. When is AzAPI better than AzureRM

When a needed Azure feature is not yet available in AzureRM.

### 88. When are separate environment folders better than workspaces

When environment isolation, access, and deployment control need to be very explicit.

## Terraform With GitHub Actions

### 89. How would you implement Terraform through GitHub Actions

I would split the workflow into at least two paths:

- pull request workflow for validation and plan
- merge or protected branch workflow for apply

Typical implementation steps:

1. trigger on `pull_request` for plan
2. check out the repository
3. install Terraform with `hashicorp/setup-terraform`
4. authenticate to Azure
5. run `terraform fmt -check`
6. run `terraform validate`
7. run `terraform init`
8. run `terraform plan`
9. publish plan results to the PR or logs
10. only allow apply from trusted branches or approved environments

Strong interview phrasing:

"I separate plan and apply so that every infrastructure change is reviewed before execution. The PR workflow is for visibility and safety, and the protected branch workflow is for controlled deployment."

### 90. What would a good Terraform GitHub Actions workflow look like

A good workflow usually has:

- explicit triggers
- minimal token permissions
- non-interactive authentication
- formatting and validation checks
- plan on PR
- apply only after merge or approval
- concurrency control
- environment protection for production

### 91. Why should Terraform plan and apply be separated in GitHub Actions

Because they solve different problems.

- plan is for review
- apply is for execution

In practice, separation improves:

- safety
- approvals
- traceability
- rollback thinking

### 92. How would you authenticate Terraform to Azure from GitHub Actions

My preferred approach is to avoid long-lived credentials when possible.

Strong answer:

"If the organization supports it, I would prefer GitHub Actions OIDC with Azure trust instead of storing long-lived Azure credentials in GitHub secrets. If OIDC is not available in the environment yet, I would fall back to a carefully scoped service principal."

High-level OIDC steps:

1. create or choose the Azure identity
2. configure federated trust from Azure to GitHub
3. set workflow permissions such as `id-token: write`
4. log in using the Azure login action
5. run Terraform with Azure authentication available

### 93. Why is OIDC often better than storing Azure secrets in GitHub

Because it reduces reliance on long-lived credentials stored as secrets.

Benefits:

- fewer secret rotation problems
- lower credential exposure risk
- better fit for modern CI/CD security

### 94. If your workflow uses GitHub secrets, where would you store them

It depends on scope.

Options:

- repository secrets for repo-specific values
- environment secrets for environment-specific deployment values
- organization secrets for shared values used across repositories

How I choose:

"I scope secrets as narrowly as possible. For example, production-specific credentials or values belong in the production environment, not as broad repository secrets."

### 95. What breaks when a Terraform GitHub Actions workflow runs from a forked pull request

This is a very important interview question.

Common issues:

- normal secrets are not passed to fork-triggered PR workflows
- Azure authentication may fail
- backend access may fail
- plan steps requiring cloud access may not work

How I handle it:

1. keep fork PR workflows limited to safer checks like `fmt` and `validate`
2. avoid exposing privileged credentials to untrusted PRs
3. only run full plan/apply in trusted contexts

### 96. Why should you be careful with `pull_request_target` for Terraform workflows

Because it runs in the context of the base repository and can have stronger permissions. If used carelessly with untrusted code, it can become dangerous.

Good interview phrasing:

"I treat `pull_request_target` carefully because it can expose elevated repository context. For Terraform workflows, I do not use it casually for privileged cloud operations on untrusted code."

### 97. How would you control `GITHUB_TOKEN` permissions in a Terraform workflow

I would use minimum required permissions.

Typical idea:

- read-only where possible
- add write permissions only for specific needs like PR comments

Why:

- reduces repository risk
- limits what actions can do if something goes wrong

### 98. Why is concurrency important in Terraform GitHub Actions workflows

Because multiple applies against the same environment can conflict.

What I do:

1. define a concurrency group for the environment or workflow
2. cancel outdated runs where appropriate
3. avoid parallel applies to the same state

Example reasoning:

"If two runs target the same production environment at the same time, even if Terraform state locking helps, the workflow layer should also avoid unnecessary overlap."

### 99. How would you use GitHub Environments with Terraform

I use environments for:

- approval gates
- environment-scoped secrets
- branch restrictions

Typical pattern:

- `dev` environment may auto-apply
- `prod` environment requires approval before apply

### 100. How would you design a Terraform PR workflow in GitHub Actions

My design would be:

1. trigger on PR
2. checkout code
3. setup Terraform
4. authenticate if trusted and needed
5. run `fmt`, `validate`, and `init`
6. run `plan`
7. publish summary or PR comment

If fork security is a concern:

- run `fmt` and `validate` on all PRs
- run plan only in trusted contexts

### 101. How would you design the apply workflow

My apply workflow would:

1. trigger on merge to protected branch, manual dispatch, or approved environment deployment
2. checkout code
3. setup Terraform
4. authenticate securely
5. initialize backend
6. run plan if needed or use reviewed plan artifact
7. apply only after protections are satisfied

### 102. Would you comment full Terraform plan output on a pull request

Not always.

Tradeoff:

- it improves visibility
- but very large plans can be noisy or expose more than needed

My approach:

- keep PR output concise
- include summary and key changes
- use artifacts or logs for larger details

### 103. How would you handle Terraform plan artifacts in GitHub Actions

If my workflow uses a saved plan for apply, I would:

1. generate the plan in a controlled step
2. store it as an artifact only if the workflow design requires it
3. ensure the apply step uses the reviewed plan
4. make sure environment and branch conditions are consistent

I also stay aware that plan files can be sensitive depending on the environment.

### 104. What are common breaking points in Terraform GitHub Actions workflows

Common breakages:

- wrong working directory
- wrong backend key
- missing Azure permissions
- secrets unavailable in fork PRs
- wrong subscription or tenant
- missing `id-token: write` for OIDC
- concurrent runs targeting the same environment
- provider version drift

### 105. What would you check if a GitHub Actions run suddenly wants to create everything again

I would check:

1. working directory
2. backend config
3. workspace or environment selection
4. Azure subscription and tenant
5. credentials used by the runner
6. whether the job is pointing to the intended state key

### 106. What would you check if `terraform init` works in GitHub Actions but `plan` fails

I would inspect:

- Azure auth context
- backend access
- variable injection
- missing secrets or environment variables
- plan-time data source access
- subscription mismatch

### 107. How would you improve a weak Terraform GitHub Actions workflow over time

I usually improve it in layers:

1. add `fmt` and `validate`
2. separate PR plan from apply
3. reduce token permissions
4. move from long-lived secrets to OIDC if possible
5. add environment approvals
6. add concurrency controls
7. add linting and security checks
8. standardize plan review

### 108. What is your view on using self-hosted runners for Terraform

They can be useful, but they increase operational responsibility.

Pros:

- network access to private infrastructure
- custom tooling
- controlled runtime

Tradeoffs:

- patching and hardening responsibility
- less isolation than GitHub-hosted runners in many setups
- credential and network exposure must be handled carefully

### 109. What is a strong security tip for Terraform in GitHub Actions

Use least privilege everywhere:

- minimum `GITHUB_TOKEN` permissions
- minimum Azure permissions
- narrow secret scope
- avoid long-lived credentials when OIDC is available

### 110. How would you stop two production applies from running at the same time

I would use multiple layers:

1. workflow concurrency in GitHub Actions
2. environment approvals
3. Terraform remote state locking

That way both the workflow system and the Terraform backend help prevent collisions.

### 111. What is one common anti-pattern in Terraform GitHub Actions workflows

A very common anti-pattern is using the same highly privileged workflow for every event, including untrusted pull requests.

Better approach:

- use safer checks for untrusted PRs
- keep apply only for trusted and protected paths

### 112. How would you explain your GitHub Actions Terraform implementation in a real interview

A strong answer would sound like this:

"I implemented Terraform in GitHub Actions by separating pull request checks from deployment workflows. The PR workflow handled `fmt`, `validate`, and plan visibility. The apply workflow ran only from trusted branches or protected environments. I used secure Azure authentication, kept permissions minimal, added concurrency to avoid overlapping runs, and treated production deployment as an approval-based workflow rather than a simple push-to-apply pipeline."

## Final Interview Advice

- answer in layers: definition, why, how, risk
- use Azure examples
- mention state safety often
- mention blast radius often
- do not ignore recovery questions
- if asked for a best practice, explain the tradeoff behind it
