# Provider Configuration for AWS
provider "aws" {
  region = var.aws_region
}

# AWS EKS provider
provider "aws" {
  region = var.aws_region
  version = "~> 4.0" # Ensure using an appropriate version
}

