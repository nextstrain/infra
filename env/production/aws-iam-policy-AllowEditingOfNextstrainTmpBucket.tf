import {
  to = aws_iam_policy.AllowEditingOfNextstrainTmpBucket
  id = "arn:aws:iam::827581582529:policy/AllowEditingOfNextstrainTmpBucket"
}

resource "aws_iam_policy" "AllowEditingOfNextstrainTmpBucket" {
  name = "AllowEditingOfNextstrainTmpBucket"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "BucketActions",
        "Effect": "Allow",
        "Action": [
          "s3:ListBucket"
        ],
        "Resource": [
          "arn:aws:s3:::nextstrain-tmp"
        ]
      },
      {
        "Sid": "ObjectActions",
        "Effect": "Allow",
        "Action": [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:PutObject",
          "s3:DeleteObject"
        ],
        "Resource": [
          "arn:aws:s3:::nextstrain-tmp/*"
        ]
      }
    ]
  })
}
