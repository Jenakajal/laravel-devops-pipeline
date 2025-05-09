provider "aws" {
  region = "us-west-2"  # Replace with your preferred AWS region
}

# Define EKS cluster
resource "aws_eks_cluster" "this" {
  name     = "example-cluster"
  role_arn = var.eks_role_arn

  # Define VPC and subnet configuration here (adjust to match your setup)
  vpc_config {
    subnet_ids = [var.vpc_id]  # Use your VPC ID here
  }
}

# Define EKS Node Group
resource "aws_eks_node_group" "this" {
  node_group_name = "example-node-group"
  cluster_name    = aws_eks_cluster.this.name
  node_role_arn   = var.eks_role_arn

  # Set node group size from the provided variables
  desired_size = var.desired_size
  min_size     = var.min_size
  max_size     = var.max_size

  # Optional: Define instance types or other configurations for the nodes
  instance_types = ["t3.medium"]

  # Optional: Define additional configuration like scaling and disk size
  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }

  # Define other configurations like subnets if needed
  subnet_ids = [var.vpc_id]  # Replace with actual subnet IDs
}

# Example for KMS Key
resource "aws_kms_alias" "this" {
  name          = "alias/eks-encryption"
  target_key_id = "arn:aws:kms:us-west-2:123456789012:key/abc12345-6789-0123-4567-89abcdef0123"  # Replace with actual KMS key ID
}

