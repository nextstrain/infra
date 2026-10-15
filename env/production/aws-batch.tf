locals {
  job_queues = {
    "nextstrain-job-queue" = {
      compute_environment = aws_batch_compute_environment.c7a_instances_2026_05_24.arn
    }
    "nextstrain-job-queue-test" = {
      compute_environment = aws_batch_compute_environment.c7a_instances_2026_05_24.arn
    }
    "nextstrain-job-queue-c7a-12xlarge" = {
      compute_environment = aws_batch_compute_environment.c7a_12xlarge.arn
    }
  }
}

# TODO: remove after move is applied
moved {
  from = aws_batch_job_queue.nextstrain_job_queue
  to   = aws_batch_job_queue.queue["nextstrain-job-queue"]
}
moved {
  from = aws_batch_job_queue.nextstrain_job_queue_test
  to   = aws_batch_job_queue.queue["nextstrain-job-queue-test"]
}
moved {
  from = aws_batch_job_queue.nextstrain_job_queue_c7a_12xlarge
  to   = aws_batch_job_queue.queue["nextstrain-job-queue-c7a-12xlarge"]
}

resource "aws_batch_job_queue" "queue" {
  for_each = local.job_queues
  name     = each.key
  priority = 1
  state    = "ENABLED"

  compute_environment_order {
    order               = 1
    compute_environment = each.value.compute_environment
  }

  # Automatically cancel some jobs stuck in RUNNABLE.
  # <https://docs.aws.amazon.com/batch/latest/userguide/job_stuck_in_runnable_time_limit_actions.html>
  job_state_time_limit_action {
    state            = "RUNNABLE"
    reason           = "MISCONFIGURATION:COMPUTE_ENVIRONMENT_MAX_RESOURCE"
    max_time_seconds = 600  # 10 minutes - shortest allowed duration
    action           = "CANCEL"
  }
  job_state_time_limit_action {
    state            = "RUNNABLE"
    reason           = "MISCONFIGURATION:JOB_RESOURCE_REQUIREMENT"
    max_time_seconds = 600  # 10 minutes - shortest allowed duration
    action           = "CANCEL"
  }
}

import {
  to = aws_batch_compute_environment.c7a_instances_2026_05_24
  id = "c7a-instances-2026-05-24"
}

resource "aws_batch_compute_environment" "c7a_instances_2026_05_24" {
  name         = "c7a-instances-2026-05-24"
  service_role = "arn:aws:iam::827581582529:role/aws-service-role/batch.amazonaws.com/AWSServiceRoleForBatch"
  state        = "ENABLED"
  type         = "MANAGED"

  compute_resources {
    allocation_strategy = "BEST_FIT"
    instance_role       = "arn:aws:iam::827581582529:instance-profile/ecsInstanceRole"
    # Details: https://aws.amazon.com/ec2/pricing/on-demand/
    instance_type = [
      "c7a.medium",
      "c7a.large",
      "c7a.xlarge",
      "c7a.2xlarge",
      "c7a.4xlarge",
      "c7a.8xlarge",
    ]
    max_vcpus           = 512
    min_vcpus           = 0
    # TODO: Import VPC resources into Terraform and pull their IDs
    # dynamically instead of hardcoding them here.
    security_group_ids  = ["sg-09316f4e9077adc8c"]
    subnets             = ["subnet-ece172e0"]
    type                = "EC2"

    ec2_configuration {
      image_type = "ECS_AL2023"
    }

    # TODO: Import the launch template into Terraform and pull its name
    # dynamically instead of hardcoding it here.
    launch_template {
      launch_template_name = "nextstrain-jobs-aws-batch"
      version              = "14"
    }
  }
}

resource "aws_batch_compute_environment" "c7a_12xlarge" {
  name         = "c7a-12xlarge"
  service_role = "arn:aws:iam::827581582529:role/aws-service-role/batch.amazonaws.com/AWSServiceRoleForBatch"
  state        = "ENABLED"
  type         = "MANAGED"

  compute_resources {
    allocation_strategy = "BEST_FIT"
    instance_role       = "arn:aws:iam::827581582529:instance-profile/ecsInstanceRole"
    # Details: https://aws.amazon.com/ec2/pricing/on-demand/
    instance_type = [
      "c7a.medium",
      "c7a.large",
      "c7a.xlarge",
      "c7a.2xlarge",
      "c7a.4xlarge",
      "c7a.8xlarge",
      "c7a.12xlarge",
    ]
    max_vcpus           = 512
    min_vcpus           = 0
    # TODO: Import VPC resources into Terraform and pull their IDs
    # dynamically instead of hardcoding them here.
    security_group_ids  = ["sg-09316f4e9077adc8c"]
    subnets             = ["subnet-ece172e0"]
    type                = "EC2"

    ec2_configuration {
      image_type = "ECS_AL2023"
    }

    # TODO: Import the launch template into Terraform and pull its name
    # dynamically instead of hardcoding it here.
    launch_template {
      launch_template_name = "nextstrain-jobs-aws-batch"
      version              = "14"
    }
  }
}
