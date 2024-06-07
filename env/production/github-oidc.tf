resource "github_actions_repository_oidc_subject_claim_customization_template" "nextstrain" {
  for_each = toset(keys(local.repo_pathogens))
  repository = each.key

  # <https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect>
  use_default = false
  include_claim_keys = [
    # The GitHub default…
    "repo",
    "context",

    # …plus the <org>/<repo>/<path>@<ref> of the *reusable* workflow obtaining the token, if any.
    "job_workflow_ref",

    # …plus the <org>/<repo>/<path>@<ref> of the workflow obtaining the token.
    "workflow_ref",
  ]
}
