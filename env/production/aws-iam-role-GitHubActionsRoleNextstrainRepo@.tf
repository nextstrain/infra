# Per-repo role, granting access to pathogens
resource "aws_iam_role" "GitHubActionsRoleNextstrainRepo" {
  for_each = local.repo_pathogens

  name = "GitHubActionsRoleNextstrainRepo@${each.key}"
  description = "Provides permissions to upload datasets, workflow files, etc. for a Nextstrain pathogen to select repos and select GitHub Actions OIDC workflows."

  max_session_duration = 43200 # seconds (12 hours)

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
            "token.actions.githubusercontent.com:sub": "repo:nextstrain/${each.key}:*:job_workflow_ref:nextstrain/.github/.github/workflows/pathogen-repo-build.yaml@*"
          }
        },
      }
    ]
  })

  managed_policy_arns = flatten([
    # Pathogen-specific permissions to standard public/private buckets
    [for p in each.value: aws_iam_policy.NextstrainPathogen[p].arn],

    # Special-case repos associated with ncov
    contains(each.value, "ncov")
      ? [aws_iam_policy.NextstrainPathogenNcovPrivate.arn,
         aws_iam_policy.NextstrainPathogenNcovNonStandardPaths.arn]
      : [],

    # Special-case forecasts-ncov repo
    each.key == "forecasts-ncov"
      ? [aws_iam_policy.NextstrainPathogenNcovPrivateReadOnly.arn]
      : [],

    # Builds inside the AWS Batch runtime need access to the jobs bucket.
    aws_iam_policy.NextstrainJobsAccessToBucket.arn,
  ])

  inline_policy {}
}
