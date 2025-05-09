# Define the AWS VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
}

# Define the Public Subnets
resource "aws_subnet" "public" {
  count = var.public_subnet_count

  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.${count.index}.0/24"
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet ${count.index}"
  }
}

# Define the Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

# Define IAM Role for EKS Cluster
resource "aws_iam_role" "eks_cluster_role" {
  name = var.eks_cluster_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

# Define the EKS Cluster
resource "aws_eks_cluster" "eks" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn
  vpc_config {
    subnet_ids = aws_subnet.public[*].id
  }
}

# Define IAM Role for EKS Node Group
resource "aws_iam_role" "eks_node_role" {
  name = var.eks_node_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# Define EKS Node Group
resource "aws_eks_node_group" "eks_managed_node_group" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = var.eks_node_group_name
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = aws_subnet.public[*].id
}

# Output the EKS Cluster Name
output "eks_cluster_name" {
  value = aws_eks_cluster.eks.name
}

# Output the EKS Cluster Endpoint
output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

# Output the EKS Cluster ARN
output "eks_cluster_arn" {
  value = aws_eks_cluster.eks.arn
}

# Output the EKS Cluster Role ARN
output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

# Output the EKS Node Group Name
output "eks_node_group_name" {
  value = aws_eks_node_group.eks_managed_node_group.node_group_name
}

# Output the EKS Node Group Status
output "eks_node_group_status" {
  value = aws_eks_node_group.eks_managed_node_group.status
}

# Output the EKS Node Role ARN
output "eks_node_role_arn" {
  value = aws_iam_role.eks_node_role.arn
}

# Output the VPC ID
output "vpc_id" {
  value = aws_vpc.main.id
}

# Output the Subnet IDs
output "subnet_ids" {
  value = aws_subnet.public[*].id
}

# Output the Internet Gateway ID
output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}

