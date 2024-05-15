terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "registry.terraform.io/hashicorp/aws"
      version = "~> 4.32"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    region = "us-east-1"

    # Default workspace uses s3://nextstrain-terraform/infra/production/tfstate
    bucket = "nextstrain-terraform"
    key    = "infra/production/tfstate"

    # Non-default workspaces use s3://nextstrain-terraform/workspace/${name}/infra/production/tfstate
    workspace_key_prefix = "workspace"

    # Table has a LockID (string) partition/primary key
    dynamodb_table = "nextstrain-terraform-locks"
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "github" {
  # Authn is via GITHUB_TOKEN
  owner = "nextstrain"
}
