import {
  to = aws_iam_openid_connect_provider.github-actions
  id = "arn:aws:iam::827581582529:oidc-provider/token.actions.githubusercontent.com"
}

resource "aws_iam_openid_connect_provider" "github-actions" {
  url = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]

  /* AWS special-cases GitHub's IdP and trusts it via trusted CA cert chains
   * instead of exact cert thumbprints.  This wasn't the case when we first set
   * this up, so we still have an exact thumbprint (but it's not used any
   * more).
   *
   * <https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc_verify-thumbprint.html>
   */
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}
