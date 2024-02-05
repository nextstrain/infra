import {
  to = aws_iam_policy.NextstrainJobsAccessToBucket
  id = "arn:aws:iam::827581582529:policy/NextstrainJobsAccessToBucket"
}

resource "aws_iam_policy" "NextstrainJobsAccessToBucket" {
  name = "NextstrainJobsAccessToBucket"
  description = "Allows listing of nextstrain-jobs bucket contents and PUT, GET, DELETE operations on all bucket objects. "

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "VisualEditor0",
        "Effect": "Allow",
        "Action": [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:DeleteObject"
        ],
        "Resource": [
          "arn:aws:s3:::nextstrain-jobs/*",
          "arn:aws:s3:::nextstrain-jobs",
          "arn:aws:s3:::nextstrain-scratch/*",
          "arn:aws:s3:::nextstrain-scratch"
        ]
      }
    ]
  })
}
