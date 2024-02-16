# Nextstrain infrastructure

Terraform configurations and related data and code for managing Nextstrain
infrastructure on AWS (and maybe eventually Heroku, DNSimple, and more).

This repository is for shared or cross-project infrastructure.
Project-specific infrastructure for nextstrain.org is managed by [Terraform
configurations in that repository][nextstrain.org's Terraform documentation].

[nextstrain.org's Terraform documentation]: https://docs.nextstrain.org/projects/nextstrain-dot-org/page/terraform.html


## Documentation

To come.  For now, refer to [nextstrain.org's Terraform documentation][].  The
set ups are similar, though not identical.

One notable difference is that this repository uses [`import {}` blocks][]
instead of the [`terraform import` command][] to bring existing resources into
the fold.  It's a much nicer experience that's harder to mess up and requires
less understanding about Terraform state management.

[`import {}` blocks]: https://developer.hashicorp.com/terraform/language/import
[`terraform import` command]: https://developer.hashicorp.com/terraform/cli/commands/import


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
