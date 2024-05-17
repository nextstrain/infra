# XXX FIXME: describe what we're doing here
# <https://catnekaise.github.io/github-actions-abac-aws/cognito-identity/>
# <https://catnekaise.github.io/github-actions-abac-aws/detailed-explanation/>
# <https://awsteele.com/blog/2023/10/25/aws-role-session-tags-for-github-actions.html>
resource "aws_cognito_identity_pool" "github-actions" {
  identity_pool_name = "github-actions"
  allow_unauthenticated_identities = false
  allow_classic_flow = true
  openid_connect_provider_arns = [aws_iam_openid_connect_provider.github-actions.arn]
}

resource "aws_cognito_identity_pool_provider_principal_tag" "github-actions" {
  identity_pool_id = aws_cognito_identity_pool.github-actions.id
  identity_provider_name = aws_iam_openid_connect_provider.github-actions.id
  use_defaults = false
  principal_tags = {
    # tag name = OIDC token claim
    repository_owner = "repository_owner"
    repository       = "repository"
    job_workflow_ref = "job_workflow_ref"
  }
}
