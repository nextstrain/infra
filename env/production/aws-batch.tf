import {
  to = aws_batch_job_queue.nextstrain_job_queue
  id = "arn:aws:batch:us-east-1:827581582529:job-queue/nextstrain-job-queue"
}

resource "aws_batch_job_queue" "nextstrain_job_queue" {
  name     = "nextstrain-job-queue"
  priority = 1
  state    = "ENABLED"

  compute_environment_order {
    order               = 1
    compute_environment = aws_batch_compute_environment.c5_instances_2023_01_17.arn
  }
}

resource "aws_batch_job_queue" "nextstrain_job_queue_test" {
  name     = "nextstrain-job-queue-test"
  priority = 1
  state    = "ENABLED"

  compute_environment_order {
    order               = 1
    compute_environment = aws_batch_compute_environment.c5_instances_2026_05_19.arn
  }
}

import {
  to = aws_batch_compute_environment.c5_instances_2023_01_17
  id = "c5-instances-2023-01-17"
}

resource "aws_batch_compute_environment" "c5_instances_2023_01_17" {
  name         = "c5-instances-2023-01-17"
  service_role = "arn:aws:iam::827581582529:role/aws-service-role/batch.amazonaws.com/AWSServiceRoleForBatch"
  state        = "ENABLED"
  type         = "MANAGED"

  compute_resources {
    allocation_strategy = "BEST_FIT"
    instance_role       = "arn:aws:iam::827581582529:instance-profile/ecsInstanceRole"
    instance_type       = ["c5"]
    max_vcpus           = 512
    min_vcpus           = 0
    # TODO: Import VPC resources into Terraform and pull their IDs
    # dynamically instead of hardcoding them here.
    security_group_ids  = ["sg-09316f4e9077adc8c"]
    subnets             = ["subnet-ece172e0"]
    type                = "EC2"

    ec2_configuration {
      image_type = "ECS_AL2"
    }

    # TODO: Import the launch template into Terraform and pull its name
    # dynamically instead of hardcoding it here.
    launch_template {
      launch_template_name = "nextstrain-jobs-aws-batch"
      version              = "14"
    }
  }
}

resource "aws_batch_compute_environment" "c5_instances_2026_05_19" {
  name         = "c5-instances-2026-05-19"
  service_role = "arn:aws:iam::827581582529:role/aws-service-role/batch.amazonaws.com/AWSServiceRoleForBatch"
  state        = "ENABLED"
  type         = "MANAGED"

  compute_resources {
    allocation_strategy = "BEST_FIT"
    instance_role       = "arn:aws:iam::827581582529:instance-profile/ecsInstanceRole"
    instance_type       = ["c5"]
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
