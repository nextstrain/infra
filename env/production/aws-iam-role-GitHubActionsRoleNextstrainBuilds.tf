resource "aws_iam_role" "GitHubActionsRoleNextstrainBuilds" {
  name = "GitHubActionsRoleNextstrainBuilds"
  description = "Provides permissions for a Nextstrain build (i.e. in a pathogen repo) to upload datasets, workflow files, etc. for select GitHub Actions OIDC workflows."

  max_session_duration = 43200 # seconds (12 hours)

  assume_role_policy = aws_iam_role.GitHubActionsRoleNextstrainBatchJobs.assume_role_policy

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
            "arn:aws:s3:::nextstrain-staging",
          ],
          "Condition": {
            "StringLike": {
              "s3:prefix": [
                "$${sts:RoleSessionName}.json",
                "$${sts:RoleSessionName}_*.json",
                "files/workflows/$${sts:RoleSessionName}/*",
                "files/datasets/$${sts:RoleSessionName}/*",
              ]
            }
          }
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
            # Auspice dataset JSONs
            "arn:aws:s3:::nextstrain-data/$${sts:RoleSessionName}.json",
            "arn:aws:s3:::nextstrain-data/$${sts:RoleSessionName}_*.json",
            "arn:aws:s3:::nextstrain-staging/$${sts:RoleSessionName}.json",
            "arn:aws:s3:::nextstrain-staging/$${sts:RoleSessionName}_*.json",
            "arn:aws:s3:::nextstrain-staging/trial_*_$${sts:RoleSessionName}.json",
            "arn:aws:s3:::nextstrain-staging/trial_*_$${sts:RoleSessionName}_*.json",

            # Associated data files
            # <https://docs.nextstrain.org/en/latest/reference/data-files.html>
            "arn:aws:s3:::nextstrain-data/files/workflows/$${sts:RoleSessionName}/*",
            "arn:aws:s3:::nextstrain-data/files/datasets/$${sts:RoleSessionName}/*",
            "arn:aws:s3:::nextstrain-data-private/files/workflows/$${sts:RoleSessionName}/*",
            "arn:aws:s3:::nextstrain-data-private/files/datasets/$${sts:RoleSessionName}/*",
            "arn:aws:s3:::nextstrain-staging/files/workflows/$${sts:RoleSessionName}/*",
            "arn:aws:s3:::nextstrain-staging/files/datasets/$${sts:RoleSessionName}/*",
          ],
        },
        {
          "Sid": "NcovPrivateList",
          "Effect": "Allow",
          "Action": [
            "s3:ListBucket",
            "s3:ListBucketVersions",
            "s3:GetBucketLocation",
            "s3:GetBucketVersioning",
          ],
          "Resource": [
            "arn:aws:s3:::nextstrain-ncov-private",
          ],
          "Condition": {
            "StringEquals": {
              "aws:PrincipalTag/repository": [
                "nextstrain/ncov",
                "nextstrain/ncov-ingest",
                # XXX TODO: forecasts-ncov?
              ],
            },
          }
        },
        {
          "Sid": "NcovPrivateReadWrite",
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
            # This bucket is akin to nextstrain-data-private/files/{workflows,datasets}/ncov/.
            "arn:aws:s3:::nextstrain-ncov-private/*",
          ],
          "Condition": {
            "StringEquals": {
              "aws:PrincipalTag/repository": [
                "nextstrain/ncov",
                "nextstrain/ncov-ingest",
                # XXX TODO: forecasts-ncov?
              ]
            },
          },
        },
      ]
    })
  }
}
