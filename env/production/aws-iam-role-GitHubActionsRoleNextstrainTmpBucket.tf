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

  inline_policy {
    name = "nextstrain-tmp"
    policy = jsonencode({
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "BucketActions",
          "Effect": "Allow",
          "Action": [
            "s3:ListBucket"
          ],
          "Resource": [
            "arn:aws:s3:::nextstrain-tmp"
          ]
        },
        {
          "Sid": "ObjectActions",
          "Effect": "Allow",
          "Action": [
            "s3:GetObject",
            "s3:GetObjectVersion",
            "s3:PutObject",
            "s3:DeleteObject"
          ],
          "Resource": [
            "arn:aws:s3:::nextstrain-tmp/*"
          ]
        }
      ]
    })
  }
  managed_policy_arns = []
}
