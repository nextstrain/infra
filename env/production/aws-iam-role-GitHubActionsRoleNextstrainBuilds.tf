resource "aws_iam_role" "GitHubActionsRoleNextstrainBuilds" {
  name = "GitHubActionsRoleNextstrainBuilds"
  description = "Provides permissions for a Nextstrain build (i.e. in a pathogen repo) to upload datasets, workflow files, etc. for select GitHub Actions OIDC workflows."

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
            "token.actions.githubusercontent.com:sub": "repo:nextstrain/*:*:job_workflow_ref:nextstrain/.github/.github/workflows/pathogen-repo-build.yaml@refs/heads/*",
          }
        },
      }
    ]
  })

  # This role provides a superset of the permissions expected to actually be
  # required by any individual Nextstrain pathogen build.  In practice, we
  # further scope down permissions per-repo using an inline session policy
  # declared in our centralized and trusted pathogen-repo-build workflow.  The
  # inline session policy is obviously less of a hard boundary, but it still
  # provides guardrails against accidental operations.  See also the discussion
  # in <https://github.com/nextstrain/private/issues/96>.
  #   -trs, 15 May 2024
  managed_policy_arns = [
    # Builds inside the AWS Batch runtime need access to the jobs bucket.
    aws_iam_policy.NextstrainJobsAccessToBucket.arn,
  ]

  # All builds need a subset of this access for downloading starting data and
  # publishing results.
  inline_policy {
    name = "S3Access"
    policy = jsonencode({
      "Version": "2012-10-17",
      "Statement": [
        # Technically we don't need to include the public buckets
        # nextstrain-data and nextstrain-staging in this statement since they
        # already allow a superset of this with their bucket policies, but it's
        # good to be explicit about what permissions we require.
        #   -trs, 16 Feb 2024
        {
          "Sid": "List",
          "Effect": "Allow",
          "Action": [
            "s3:ListBucket",
            "s3:ListBucketVersions",
            "s3:GetBucketLocation",
            "s3:GetBucketVersioning",
          ],
          "Resource": [
            "arn:aws:s3:::nextstrain-data",
            "arn:aws:s3:::nextstrain-data-private",
            "arn:aws:s3:::nextstrain-ncov-private",
            "arn:aws:s3:::nextstrain-staging",
          ],
        },
        {
          "Sid": "ReadWrite",
          "Effect": "Allow",
          "Action": [
            "s3:GetObject",
            "s3:GetObjectTagging",
            "s3:GetObjectVersion",
            "s3:GetObjectVersionTagging",
            "s3:PutObject",
            "s3:PutObjectTagging",
            "s3:DeleteObject",
            # but NOT s3:DeleteObjectVersion so objects can't be completely wiped
          ],
          "Resource": [
            "arn:aws:s3:::nextstrain-data/*.json",
            "arn:aws:s3:::nextstrain-data/files/workflows/*",
            "arn:aws:s3:::nextstrain-data/files/datasets/*",

            "arn:aws:s3:::nextstrain-data-private/*.json",
            "arn:aws:s3:::nextstrain-data-private/files/workflows/*",
            "arn:aws:s3:::nextstrain-data-private/files/datasets/*",

            # This bucket is akin to nextstrain-data-private/files/{workflows,datasets}/ncov/.
            "arn:aws:s3:::nextstrain-ncov-private/*",

            "arn:aws:s3:::nextstrain-staging/*.json",
            "arn:aws:s3:::nextstrain-staging/files/workflows/*",
            "arn:aws:s3:::nextstrain-staging/files/datasets/*",
          ],
        },
      ]
    })
  }
}
