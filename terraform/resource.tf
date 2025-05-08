# Provider configuration for AWS
provider "aws" {
  region = var.aws_region
}

# VPC resource
resource "aws_vpc" "eks_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = "${var.cluster_name}-vpc"
  }
}

# Public Subnets
resource "aws_subnet" "eks_public_subnets" {
  count = length(var.public_subnets)

  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet ${count.index}"
  }
}

# Private Subnets
resource "aws_subnet" "eks_private_subnets" {
  count = length(var.private_subnets)

  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.private_subnets[count.index]
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = false
  tags = {
    Name = "Private Subnet ${count.index}"
  }
}

# Internet Gateway (for public subnets)
resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Name = "${var.cluster_name}-internet-gateway"
  }
}

# Route Table for Public Subnet
resource "aws_route_table" "eks_public_route_table" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks_igw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

# Associate the route table with the public subnets
resource "aws_route_table_association" "eks_public_route_table_association" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.eks_public_subnets[count.index].id
  route_table_id = aws_route_table.eks_public_route_table.id
}

# EKS Cluster
resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn
  vpc_config {
    subnet_ids = aws_subnet.eks_private_subnets[*].id
    endpoint_public_access = true
    endpoint_private_access = true
  }

  depends_on = [aws_iam_role_policy_attachment.eks_cluster_policy]
}

# EKS Node Group Role (IAM role for the worker nodes)
resource "aws_iam_role" "eks_node_group_role" {
  name = "${var.cluster_name}-node-group-role"

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
      },
    ]
  })
}

# Attach policies to the node group role
resource "aws_iam_role_policy_attachment" "eks_node_group_policy_attachment" {
  role       = aws_iam_role.eks_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

# EKS Node Group
resource "aws_eks_node_group" "eks_node_group" {
  cluster_name_

