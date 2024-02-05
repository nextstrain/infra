import {
  to = aws_iam_role.GitHubActionsRoleNextstrainBatchJobs
  id = "GitHubActionsRoleNextstrainBatchJobs"
}

resource "aws_iam_role" "GitHubActionsRoleNextstrainBatchJobs" {
  name = "GitHubActionsRoleNextstrainBatchJobs"
  description = "Provides permissions to run jobs on AWS Batch via the Nextstrain CLI to select GitHub Actions OIDC workflows."

  max_session_duration = 43200 # seconds (12 hours)

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Federated": aws_iam_openid_connect_provider.github-actions.arn
        }
        "Action": "sts:AssumeRoleWithWebIdentity",
        "Condition": {
          "StringLike": {
            "token.actions.githubusercontent.com:aud": "sts.amazonaws.com",
            "token.actions.githubusercontent.com:sub": "repo:nextstrain/.github:*"
          }
        },
      }
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::827581582529:policy/NextstrainJobsAccessToBatch",
    "arn:aws:iam::827581582529:policy/NextstrainJobsAccessToBucket",
    "arn:aws:iam::827581582529:policy/NextstrainJobsAccessToLogs",
  ]
  inline_policy {}
}
