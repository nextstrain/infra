import {
  to = aws_iam_role.GitHubActionsRoleNextstrainS3Access
  id = "GitHubActionsRoleNextstrainS3Access"
}

resource "aws_iam_role" "GitHubActionsRoleNextstrainS3Access" {
  name = "GitHubActionsRoleNextstrainS3Access"
  description = "Provides read/write access Nextstrain S3 buckets to Nextstrain GitHub Actions OIDC workflows."

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
            "token.actions.githubusercontent.com:sub": "repo:nextstrain/*:job_workflow_ref:nextstrain/.github/.github/workflows/pathogen-repo-build.yaml@*"
          }
        },
      }
    ]
  })

  managed_policy_arns = [
    aws_iam_policy.AllowEditingOfNextstrainDataBucket.arn,
    aws_iam_policy.AllowEditingOfNextstrainDataPrivateBucket.arn,
    aws_iam_policy.AllowEditingOfNextstrainNcovPrivateBucket.arn,
    aws_iam_policy.AllowEditingOfNextstrainStagingBucket.arn,
  ]
  inline_policy {}
}
