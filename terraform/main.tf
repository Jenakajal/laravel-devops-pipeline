# main.tf

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Default AWS provider
provider "aws" {
  region = var.region
}

# Aliased AWS provider for EKS
provider "aws" {
  alias  = "eks"
  region = var.region
}

resource "aws_eks_cluster" "eks" {
  provider = aws.eks

  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = aws_subnet.subnet_ids.*.id
  }

  # Kubernetes version (latest or defined)
  version = var.k8s_version
}

# IAM role for EKS cluster to access required services
resource "aws_iam_role" "eks_cluster_role" {
  provider = aws

  name = "${var.cluster_name}-eks-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      }
    ]
  })
}

resource "aws_eks_node_group" "node_group" {
  provider = aws.eks

  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "${var.cluster_name}-nodes"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = aws_subnet.subnet_ids.*.id

  scaling_config {
    desired_size = var.node_group_desired_size
    max_size     = var.node_group_max_size
    min_size     = var.node_group_min_size
  }

  # Update strategy
  update_config {
    max_unavailable = 1
  }

  # Node instance types and AMI
  instance_types = var.node_group_instance_types
}

# IAM role for EKS worker nodes
resource "aws_iam_role" "eks_node_role" {
  provider = aws

  name = "${var.cluster_name}-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      }
    ]
  })
}

resource "aws_security_group" "eks_security_group" {
  provider = aws

  name_prefix = "eks-sg"
  vpc_id      = aws_vpc.vpc.id
}

resource "aws_subnet" "subnet_1" {
  provider = aws

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet_2" {
  provider = aws

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true
}

resource "aws_vpc" "vpc" {
  provider = aws

  cidr_block = "10.0.0.0/16"
}

resource "aws_security_group_rule" "allow_ingress" {
  provider = aws

  type        = "ingress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.eks_security_group.id
}

resource "aws_security_group_rule" "allow_egress" {
  provider = aws

  type        = "egress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.eks_security_group.id
}

output "eks_cluster_name" {
  value = aws_eks_cluster.eks.name
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "eks_cluster_arn" {
  value = aws_eks_cluster.eks.arn
}

output "eks_node_group_id" {
  value = aws_eks_node_group.node_group.id
}

output "eks_node_group_arn" {
  value = aws_eks_node_group.node_group.arn
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnet_ids" {
  value = aws_subnet.subnet_ids.*.id
}

