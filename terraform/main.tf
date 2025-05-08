provider "aws" {
  region = "us-west-2"  # Change to your desired region
}

# VPC and Networking setup
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "eks-vpc"
  cidr   = "10.0.0.0/16"  # Change to your desired CIDR block

  enable_dns_support   = true
  enable_dns_hostnames = true

  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]  # Define your public subnets
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]  # Define your private subnets

  tags = {
    "Owner"       = "your-name"
    "Environment" = "dev"
  }
}

# Define EKS cluster
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.21"  # EKS version, change as needed
  subnets         = module.vpc.private_subnets  # Use private subnets for EKS
  vpc_id          = module.vpc.vpc_id

  node_groups = {
    eks_node_group = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_type    = "t3.medium"  # Change instance type as needed
      key_name         = "your-ssh-key"  # Optional: Use your SSH key if needed for EC2 instances
    }
  }

  node_group_defaults = {
    ami_id = "ami-xxxxxxxxxxxxxxxxx"  # Optional: specify a custom AMI ID if needed
  }

  tags = {
    "Owner"       = "your-name"
    "Environment" = "dev"
  }
}

# Output the cluster details
output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_kubeconfig" {
  value = module.eks.kubeconfig
}

output "eks_node_group_name" {
  value = module.eks.node_groups
}

