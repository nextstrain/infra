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
          "Federated": "cognito-identity.amazonaws.com"
        },
        "Action": [
          "sts:AssumeRoleWithWebIdentity",
          "sts:TagSession",
        ],
        "Condition": {
          "StringEquals": {
            "cognito-identity.amazonaws.com:aud": aws_cognito_identity_pool.github-actions.id,
            "aws:RequestTag/repository_owner": "nextstrain",
            "aws:RequestTag/respository": [
              "nextstrain/$${sts:RoleSessionName}",
              "nextstrain/$${sts:RoleSessionName}-ingest", # for ncov and ncov-ingest
            ],
          },
          "StringLike": {
            "aws:RequestTag/job_workflow_ref": "nextstrain/.github/.github/workflows/pathogen-repo-build.yaml@*",
          },
          "ForAllValues:StringLike": {
            "cognito-identity.amazonaws.com:amr": [
              "authenticated",
              "token.actions.githubusercontent.com",
              "${aws_iam_openid_connect_provider.github-actions.arn}:*",
            ],
          },
          # Ensures that a missing/empty amr claim doesn't pass the
          # ForAllValues condition above.
          "Null": {
            "cognito-identity.amazonaws.com:amr": "false",
          },
        },
      }
    ]
  })

  managed_policy_arns = [
    aws_iam_policy.NextstrainJobsAccessToBatch.arn,
    aws_iam_policy.NextstrainJobsAccessToBucket.arn,
    aws_iam_policy.NextstrainJobsAccessToLogs.arn,
  ]
  inline_policy {}
}
