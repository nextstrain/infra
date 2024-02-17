locals {
  # XXX FIXME: define in external file instead
  pathogens = [
    {
      "name": "mpox",
      "repo": "nextstrain/mpox",
      "prefix": "mpox_"
    },
    {
      "name": "rsv",
      "repo": "nextstrain/rsv",
      "prefix": "rsv_"
    },
    {
      "name": "seasonal-flu",
      "repo": "nextstrain/seasonal-flu",
      "prefix": "flu_seasonal_"
    },
    # XXX FIXME: ncov, ncov-ingest, forecasts-ncov
  ]
}

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
            "token.actions.githubusercontent.com:sub": concat(
              [for repo in local.pathogens[*].repo: "repo:${repo}:*"],

              # For testing our pathogen-repo-build.yaml workflow
              ["repo:nextstrain/.github:*"],
            )
          }
        },
      }
    ]
  })

  managed_policy_arns = [
    aws_iam_policy.NextstrainJobsAccessToBatch.arn,
    aws_iam_policy.NextstrainJobsAccessToBucket.arn,
    aws_iam_policy.NextstrainJobsAccessToLogs.arn,
  ]
  dynamic "inline_policy" {
    for_each = local.pathogens
    iterator = pathogen
    content {
      name = pathogen.value.name
      policy = jsonencode({
        "Version": "2012-10-17",
        "Statement": [
          # Technically this whole statement (ListPublicData) is unnecessary
          # since the nextstrain-data and nextstrain-staging buckets already
          # allow a superset of this with their bucket policies, but it's good to
          # be explicit about what permissions we require?
          #   -trs, 16 Feb 2024
          {
            "Sid": "ListPublicData",
            "Effect": "Allow",
            "Action": [
              "s3:ListBucket"
            ],
            "Resource": [
              "arn:aws:s3:::nextstrain-data",
              "arn:aws:s3:::nextstrain-staging",
            ],
            "Condition": {
              "StringLike": {
                "token.actions.githubusercontent.com:aud": "sts.amazonaws.com",
                "token.actions.githubusercontent.com:sub": "repo:${pathogen.value.repo}:*",
                "s3:prefix": [
                  "files/workflows/${pathogen.value.name}/*",
                  "files/datasets/${pathogen.value.name}/*",
                  "${pathogen.value.prefix}*.json",
                ]
              }
            }
          },
          {
            "Sid": "ReadWritePublicData",
            "Effect": "Allow",
            "Action": [
              "s3:GetObject",
              "s3:PutObject"
            ],
            "Resource": [
              "arn:aws:s3:::nextstrain-data/files/workflows/${pathogen.value.name}/*",
              "arn:aws:s3:::nextstrain-data/files/datasets/${pathogen.value.name}/*",
              "arn:aws:s3:::nextstrain-data/${pathogen.value.prefix}*.json",
              "arn:aws:s3:::nextstrain-staging/files/workflows/${pathogen.value.name}/*",
              "arn:aws:s3:::nextstrain-staging/files/datasets/${pathogen.value.name}/*",
              "arn:aws:s3:::nextstrain-staging/${pathogen.value.prefix}*.json",
              "arn:aws:s3:::nextstrain-staging/trial_*_${pathogen.value.prefix}*.json"
            ],
            "Condition": {
              "StringLike": {
                "token.actions.githubusercontent.com:aud": "sts.amazonaws.com",
                "token.actions.githubusercontent.com:sub": "repo:${pathogen.value.repo}:*",
              }
            }
          },
          # XXX FIXME: add general statements for nextstrain-data-private
          # XXX FIXME: add custom statements for ncov, ncov-ingest, forecasts-ncov
        ]
      })
    }
  }
}
