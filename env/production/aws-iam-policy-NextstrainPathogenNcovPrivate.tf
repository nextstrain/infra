# Single-pathogen policy, special-case for the historical reason that
# nextstrain-ncov-private predates the more general nextstrain-data-private.
resource "aws_iam_policy" "NextstrainPathogenNcovPrivate" {
  name = "NextstrainPathogen@ncov+private"
  description = "Provides permissions to upload datasets, workflow files, etc. to the ncov-private bucket for the Nextstrain ncov pathogen"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
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
      },
    ]
  })
}

resource "aws_iam_policy" "NextstrainPathogenNcovPrivateReadOnly" {
  name = "NextstrainPathogen@ncov+private-read-only"
  description = "Provides permissions to read datasets, workflow files, etc. in the ncov-private bucket for the Nextstrain ncov pathogen"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
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
      },
      {
        "Sid": "NcovPrivateReadWrite",
        "Effect": "Allow",
        "Action": [
          "s3:GetObject",
          "s3:GetObjectTagging",
          "s3:GetObjectVersion",
          "s3:GetObjectVersionTagging",
        ],
        "Resource": [
          # This bucket is akin to nextstrain-data-private/files/{workflows,datasets}/ncov/.
          "arn:aws:s3:::nextstrain-ncov-private/*",
        ],
      },
    ]
  })
}
