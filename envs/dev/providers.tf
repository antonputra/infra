provider "aws" {
  region = var.region

  profile = var.terraform_profile

  # assume_role {
  #   role_arn = var.terraform_iam_role
  # }
}

terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.80"
    }
  }
}
