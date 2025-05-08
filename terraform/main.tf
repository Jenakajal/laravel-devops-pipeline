provider "aws" {
  region = var.aws_region
}

# Define VPC
resource "aws_vpc" "eks_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
}

# Define public subnets
resource "aws_subnet" "eks_public_subnet" {
  count = 2
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = element(var.public_subnet_cidr_blocks, count.index)
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true
}

# Define private subnets
resource "aws_subnet" "eks_private_subnet" {
  count = 2
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = element(var.private_subnet_cidr_blocks, count.index)
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
}

# Define the EKS Cluster
module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name    = var.cluster_name
  cluster_version = "1.21"  # Use the EKS Kubernetes version you need
  subnets         = flatten([aws_subnet.eks_public_subnet[*].id, aws_subnet.eks_private_subnet[*].id]) # Fix: Correctly passing subnets as an array
  vpc_id          = aws_vpc.eks_vpc.id
  node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_type    = "t3.medium"
    }
  }

  node_group_name = "eks-node-group"
}

# Data source for availability zones (to distribute subnets)
data "aws_availability_zones" "available" {}


