import {
  to = aws_iam_role.GitHubActionsRoleNextstrainBatchJobs
  id = "GitHubActionsRoleNextstrainBatchJobs"
}

# Multi-repo role, granting access to Batch
resource "aws_iam_role" "GitHubActionsRoleNextstrainBatchJobs" {
  name = "GitHubActionsRoleNextstrainBatchJobs"
  description = "Provides permissions to launch and monitor jobs on AWS Batch via the Nextstrain CLI to select GitHub Actions OIDC workflows."

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
            "token.actions.githubusercontent.com:sub": flatten([
              [for repo in keys(local.repo_pathogens):
                "repo:nextstrain/${repo}:*:job_workflow_ref:nextstrain/.github/.github/workflows/pathogen-repo-build.yaml@*:workflow_ref:*"],

              # Special case for seasonal flu repo which needs to download the private builds
              # from AWS Batch before bundling/deploying them through Netlify.
              # We attempted to use the custom claim `workflow_ref` in
              # https://github.com/nextstrain/infra/pull/19/commits/538385e4d1acd5359825e22f505f4d8bd073c2bf but
              # that did not work as expected, so just allow any seasonal-flu GH Action workflow to access Batch.
              # This special case can be removed when we finally sunset the private site.
              #   -Jover, 07 June 2024
              "repo:nextstrain/seasonal-flu:*",
            ])
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
  inline_policy {}
}
