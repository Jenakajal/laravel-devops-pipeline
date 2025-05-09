provider "aws" {
  region = "us-west-2" # Replace with your AWS region
}

resource "aws_eks_cluster" "this" {
  name     = "my-cluster"
  role_arn = var.eks_role_arn
  vpc_config {
    subnet_ids = ["subnet-12345678"] # Replace with your subnet IDs
  }

  # Other cluster configurations
}

resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "my-node-group"
  node_role_arn   = var.eks_role_arn
  subnet_ids      = ["subnet-12345678"] # Replace with your subnet IDs

  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }

  # Additional node group configurations
}

