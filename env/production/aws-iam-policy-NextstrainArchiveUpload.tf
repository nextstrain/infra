resource "aws_iam_policy" "NextstrainArchiveUpload" {
  name        = "NextstrainArchiveUpload"
  description = "Provides permissions to upload to the nextstrain-archive bucket"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "ListBucket",
        "Effect": "Allow",
        "Action": "s3:ListBucket",
        "Resource": "arn:aws:s3:::nextstrain-archive"
      },
      {
        "Sid": "PutObject",
        "Effect": "Allow",
        "Action": "s3:PutObject",
        "Resource": "arn:aws:s3:::nextstrain-archive/*"
        # TODO: Condition on an if-none-match header if added by the script.
        # <https://github.com/nextstrain/ncov-ingest/blob/4a714833/bin/archive-to-s3#L20-L26>
      }
    ]
  })
}
