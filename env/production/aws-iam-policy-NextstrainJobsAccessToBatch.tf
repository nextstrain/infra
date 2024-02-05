import {
  to = aws_iam_policy.NextstrainJobsAccessToBatch
  id = "arn:aws:iam::827581582529:policy/NextstrainJobsAccessToBatch"
}

resource "aws_iam_policy" "NextstrainJobsAccessToBatch" {
  name = "NextstrainJobsAccessToBatch"
  description = "Allows access to AWS Batch job submission and monitoring and read-only access to see general job and queue definitions"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "VisualEditor0",
        "Effect": "Allow",
        "Action": [
          "batch:DescribeJobQueues",
          "batch:TerminateJob",
          "batch:DescribeJobs",
          "batch:CancelJob",
          "batch:SubmitJob",
          "batch:DescribeJobDefinitions",
          "batch:UpdateComputeEnvironment",
          "batch:ListJobs",
          "batch:DescribeComputeEnvironments",
          "batch:UpdateJobQueue",
          "batch:RegisterJobDefinition",
          "batch:ListSchedulingPolicies"
        ],
        "Resource": "*"
      },
      {
        "Sid": "VisualEditor1",
        "Effect": "Allow",
        "Action": "iam:PassRole",
        "Resource": "arn:aws:iam::*:role/NextstrainJobsRole",
      }
    ]
  })
}
