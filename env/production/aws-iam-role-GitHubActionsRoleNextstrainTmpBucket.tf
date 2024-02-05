import {
  to = aws_iam_role.GitHubActionsRoleNextstrainTmpBucket
  id = "GitHubActionsRoleNextstrainTmpBucket"
}

resource "aws_iam_role" "GitHubActionsRoleNextstrainTmpBucket" {
  name = "GitHubActionsRoleNextstrainTmpBucket"
  description = "Provides read/write access to the nextstrain-tmp S3 bucket to select GitHub Actions OIDC workflows."

  max_session_duration = 3600 # seconds (1 hour)

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Federated": aws_iam_openid_connect_provider.github-actions.arn
        },
        "Action": "sts:AssumeRoleWithWebIdentity",
        "Condition": {
          "StringLike": {
            "token.actions.githubusercontent.com:aud": "sts.amazonaws.com",
            "token.actions.githubusercontent.com:sub": "repo:nextstrain/docker-base:*"
          }
        }
      }
    ]
  })

  /* XXX TODO: Inline this instead to avoid clutter if the policy isn't going
   * to get used elsewhere?
   *   -trs, 5 Feb 2024 (originally 12 June 2023¹)
   *
   * ¹ <https://github.com/nextstrain/private/issues/22#issuecomment-1588211457>
   */
  managed_policy_arns = [aws_iam_policy.AllowEditingOfNextstrainTmpBucket.arn]
  inline_policy {}
}
