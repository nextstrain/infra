import {
  to = aws_iam_policy.NextstrainJobsAccessToLogs
  id = "arn:aws:iam::827581582529:policy/NextstrainJobsAccessToLogs"
}

resource "aws_iam_policy" "NextstrainJobsAccessToLogs" {
  name = "NextstrainJobsAccessToLogs"
  description = "Allows read-only access to CloudWatch log streams for AWS Batch jobs"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "VisualEditor0",
        "Effect": "Allow",
        "Action": [
          "logs:GetLogEvents",
          "logs:FilterLogEvents",
          "logs:DeleteLogStream"
        ],
        "Resource": [
          "arn:aws:logs:*:*:log-group:/aws/batch/job",
          "arn:aws:logs:*:*:log-group:/aws/batch/job:log-stream:*"
        ]
      }
    ]
  })
}
