import {
  to = aws_iam_policy.AllowEditingOfNextstrainNcovPrivateBucket
  id = "arn:aws:iam::827581582529:policy/AllowEditingOfNextstrainNcovPrivateBucket"
}

resource "aws_iam_policy" "AllowEditingOfNextstrainNcovPrivateBucket" {
  name = "AllowEditingOfNextstrainNcovPrivateBucket"
  description = ""

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "s3:ListAllMyBuckets",
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "s3:ListBucket",
          "s3:ListBucketVersions",
          "s3:GetBucketLocation",
          "s3:GetBucketVersioning"
        ],
        "Resource": "arn:aws:s3:::nextstrain-ncov-private"
      },
      {
        "Effect": "Allow",
        "Action": [
          "s3:PutObject",
          "s3:PutObjectTagging",
          "s3:GetObject",
          "s3:GetObjectTagging",
          "s3:GetObjectVersion",
          "s3:GetObjectVersionTagging",
          "s3:DeleteObject"
        ],
        "Resource": "arn:aws:s3:::nextstrain-ncov-private/*"
      }
    ]
  })
}
