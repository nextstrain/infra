# Nextstrain infrastructure

Terraform configurations and related data and code for managing Nextstrain
infrastructure on AWS (and maybe eventually Heroku, DNSimple, and more).

This repository is for shared or cross-project infrastructure.
Project-specific infrastructure for nextstrain.org is managed by [Terraform
configurations in that repository][nextstrain.org's Terraform documentation].

[nextstrain.org's Terraform documentation]: https://docs.nextstrain.org/projects/nextstrain-dot-org/page/terraform.html


## Synopsis

One time initialization for the configuration:

    terraform -chdir=env/production init

See what needs doing to bring actual resources into alignment with the current
configuration:

    terraform -chdir=env/production plan -out=plan

Make those changes so:

    terraform -chdir=env/production apply plan

> [!IMPORTANT]
> You'll need ambiently-configured AWS credentials with broad admin-level
> access to read (and optionally modify) resources in our account.
>
> You'll also need a `GITHUB_TOKEN` in the environment with the following
> fine-grained token permissions on our repos:
>
>   - `actions:write`
>   - `administration:write`
>
> Please step cautiously and be careful when using these two sets of
> credentials!


## Documentation

To come.  For now, refer to [nextstrain.org's Terraform documentation][].  The
set ups are similar, though not identical.

One notable difference is that this repository uses [`import {}` blocks][]
instead of the [`terraform import` command][] to bring existing resources into
the fold.  It's a much nicer experience that's harder to mess up and requires
less understanding about Terraform state management.

[`import {}` blocks]: https://developer.hashicorp.com/terraform/language/import
[`terraform import` command]: https://developer.hashicorp.com/terraform/cli/commands/import


### How to add a new pathogen repository for use with `pathogen-repo-build`

Some changes are necessary to support a repository's use of our [centralized
pathogen-repo-build.yaml GitHub Actions workflow](https://github.com/nextstrain/.github/blob/HEAD/.github/workflows/pathogen-repo-build.yaml.in).

1. Add the repository by its short name to the `pathogen_repos` variable in
   `env/production/locals.tf`.  In most cases, this will be a line like:

   ```hcl
   "repo-name" = ["repo-name"],
   ```

2. Plan, review, and apply changes using the `terraform` command.  See synopsis
   above, as well as [nextstrain.org's Terraform documentation][].

   The plan summary should be "3 to add, 1 to change, 0 to destroy".  Added
   should be:

     - `aws_iam_policy.NextstrainPathogen["repo-name"]`
     - `aws_iam_role.GitHubActionsRoleNextstrainRepo["repo-name"]`
     - `github_actions_repository_oidc_subject_claim_customization_template.nextstrain["repo-name"]`

   Changed should be:

     - `aws_iam_role.GitHubActionsRoleNextstrainBatchJobs`, a new condition
       value entry like `repo:nextstrain/repo-name:*:job_workflow_ref:…`.


## Rule of thumb

_from [previous discussion](https://github.com/nextstrain/nextstrain.org/issues/748#issuecomment-1792842452)_

Though there's not full consensus on this, I (@tsibley) think it would be very
valuable and prudent to adopt more of our cloud resources under the control of
Terraform going forward.  Long-term, the goal would be to have most resources
under source-controlled management.

The rule of thumb here would be to import existing resources into our
configuration as we need to make significant changes to them and to add new
resources straight away.  New resources are easier to add than existing
resources and adding them straight away means less future work and an initial
direction that's aligned with the long-term direction.
