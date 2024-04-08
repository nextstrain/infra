import {
  to = aws_iam_policy.AllowEditingOfNextstrainStagingBucket
  id = "arn:aws:iam::827581582529:policy/AllowEditingOfNextstrainStagingBucket"
}

resource "aws_iam_policy" "AllowEditingOfNextstrainStagingBucket" {
  name = "AllowEditingOfNextstrainStagingBucket"
  description = ""

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "s3:ListAllMyBuckets",
        "Resource": "arn:aws:s3:::*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "s3:ListBucket",
          "s3:GetBucketLocation",
          "s3:GetBucketVersioning"
        ],
        "Resource": "arn:aws:s3:::nextstrain-staging"
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
        "Resource": "arn:aws:s3:::nextstrain-staging/*"
      }
    ]
  })
}
