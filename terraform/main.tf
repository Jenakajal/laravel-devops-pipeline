# Provider block (ensure you define region)
provider "aws" {
  region = var.region
}

# Data sources (Availability Zones, IAM Policy Documents)
data "aws_availability_zones" "available" {}

# Define the IAM policy document for assume role
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions   = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# Define VPC module (Ensure to update subnet details based on your needs)
module "vpc" {
  source             = "terraform-aws-modules/vpc/aws"
  name               = "eks-vpc"
  cidr               = var.vpc_cidr
  azs                = slice(data.aws_availability_zones.available.names, 0, 2)
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  enable_nat_gateway = true
  enable_vpn_gateway = false
}

# IAM Role for EKS Worker Node (Fixed resource name)
resource "aws_iam_role" "eks_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  name               = "eks_worker_role"
  description        = "Role for EKS worker nodes"

  tags = {
    Environment = "dev"
  }
}

# KMS Key Resource (Added KMS for encryption)
resource "aws_kms_key" "this" {
  description = "KMS Key for EKS encryption"
}

# KMS Alias (Correctly linking KMS key)
resource "aws_kms_alias" "this" {
  target_key_id = aws_kms_key.this.key_id
  alias_name    = "alias/eks-encryption"
}

# EKS Cluster Resource (Ensure EKS role is referenced correctly)
resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = module.vpc.private_subnets
  }
}

# EKS Node Group Resource (Fixed reference to VPC and IAM role)
resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_role_arn   = aws_iam_role.eks_role.arn
  subnet_ids      = module.vpc.private_subnets
  instance_types  = var.node_group_instance_types
  desired_size    = var.desired_size
  min_size        = var.min_size
  max_size        = var.max_size
  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }

  tags = {
    Environment = "dev"
  }
}

