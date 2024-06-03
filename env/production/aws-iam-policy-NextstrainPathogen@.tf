# Per-pathogen policy, granting access to a single pathogen's data
resource "aws_iam_policy" "NextstrainPathogen" {
  for_each = local.pathogen_repos

  name = "NextstrainPathogen@${each.key}"
  description = "Provides permissions to upload datasets, workflow files, etc. for a Nextstrain pathogen"

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
              "${each.key}.json",
              "${each.key}_*.json",
              "files/workflows/${each.key}/*",
              "files/datasets/${each.key}/*",
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
          "arn:aws:s3:::nextstrain-data/${each.key}.json",
          "arn:aws:s3:::nextstrain-data/${each.key}_*.json",
          "arn:aws:s3:::nextstrain-staging/${each.key}.json",
          "arn:aws:s3:::nextstrain-staging/${each.key}_*.json",
          "arn:aws:s3:::nextstrain-staging/trial_*_${each.key}.json",
          "arn:aws:s3:::nextstrain-staging/trial_*_${each.key}_*.json",

          # Associated data files
          # <https://docs.nextstrain.org/en/latest/reference/data-files.html>
          "arn:aws:s3:::nextstrain-data/files/workflows/${each.key}/*",
          "arn:aws:s3:::nextstrain-data/files/datasets/${each.key}/*",
          "arn:aws:s3:::nextstrain-data-private/files/workflows/${each.key}/*",
          "arn:aws:s3:::nextstrain-data-private/files/datasets/${each.key}/*",
          "arn:aws:s3:::nextstrain-staging/files/workflows/${each.key}/*",
          "arn:aws:s3:::nextstrain-staging/files/datasets/${each.key}/*",
        ],
      },
      {
        "Sid": "CloudFrontList",
        "Effect": "Allow",
        "Action": [
          "cloudfront:ListDistributions",
        ],
        "Resource": "*",
      },
      {
        "Sid": "CloudFrontReadWrite",
        "Effect": "Allow",
        "Action": [
          "cloudfront:CreateInvalidation",
          "cloudfront:GetInvalidation",
        ],
        # XXX TODO: Import CloudFront resources into Terraform and pull their
        # IDs dynamically instead of hardcoding them here.
        #   -trs, 31 May 2024
        "Resource": [
          "arn:aws:cloudfront::827581582529:distribution/E3LB0EWZKCCV",   # data.nextstrain.org
          "arn:aws:cloudfront::827581582529:distribution/E3L83FTHWUN0BV", # staging.nextstrain.org
        ],
      }
    ]
  })
}
