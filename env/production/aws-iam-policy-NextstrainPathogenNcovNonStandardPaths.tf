# Single-pathogen policy, special-case for the historical reason that
# ncov uses the non-standard files/ncov/ paths.
resource "aws_iam_policy" "NextstrainPathogenNcovNonStandardPaths" {
  name = "NextstrainPathogen@ncov+non-standard-paths"
  description = "Provides permissions to upload workflow files for the Nextstrain ncov pathogen to its non-standard paths"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
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
          "arn:aws:s3:::nextstrain-staging",
        ],
        "Condition": {
          "StringLike": {
            "s3:prefix": [
              "files/ncov/*",
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
          "arn:aws:s3:::nextstrain-data/files/ncov/*",
          "arn:aws:s3:::nextstrain-staging/files/ncov/*",
        ],
      },
    ]
  })
}
