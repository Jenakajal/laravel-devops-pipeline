provider "aws" {
  region = "us-west-2"  # Modify the region as per your setup
}

# Data Sources
data "aws_iam_policy_document" "eks_kms_key_policy" {
  statement {
    actions   = ["kms:Encrypt", "kms:Decrypt"]
    resources = ["*"]
  }
}

# IAM Role for EKS
resource "aws_iam_role" "this" {
  name = "eks-role"

  assume_role_policy = data.aws_iam_policy_document.eks_kms_key_policy.json
}

# KMS Key for Encryption
resource "aws_kms_key" "this" {
  description = "KMS key for encrypting EKS resources"
  policy      = data.aws_iam_policy_document.eks_kms_key_policy.json
}

# KMS Alias for the encryption key
resource "aws_kms_alias" "this" {
  name          = "alias/eks-encryption"  # Corrected argument
  target_key_id = aws_kms_key.this.key_id
}

# VPC, Subnets, and other networking configurations
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "private" {
  count = 2
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.${count.index}.0/24"
  availability_zone = "us-west-2a"
}

# EKS Cluster
resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = aws_iam_role.this.arn
  vpc_config {
    subnet_ids = aws_subnet.private.*.id
  }

  encryption_config {
    provider {
      key_arn = aws_kms_key.this.arn
    }
    resources = ["secrets"]
  }
}

# EKS Node Group
resource "aws_eks_node_group" "this" {
  node_group_name = "my-node-group"
  cluster_name    = aws_eks_cluster.this.name
  node_role_arn   = aws_iam_role.this.arn
  subnet_ids      = aws_subnet.private.*.id

  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }

  instance_types = var.node_group_instance_types
}

# Output EKS Cluster Details
output "cluster_name" {
  value = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "cluster_arn" {
  value = aws_eks_cluster.this.arn
}

