provider "aws" {
  region = "ap-south-1"
}

# Define the EKS cluster
resource "aws_eks_cluster" "eks-cluster" {
  name     = "devops-eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = aws_subnet.subnet_ids
  }
}

# IAM role for EKS
resource "aws_iam_role" "eks_cluster_role" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

# Define IAM role policy separately (replacing inline policy)
resource "aws_iam_role_policy" "eks_cluster_policy" {
  role   = aws_iam_role.eks_cluster_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "eks:DescribeCluster"
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

# Define node group
resource "aws_eks_node_group" "jenkins" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "jenkins-node-group"
  node_role_arn   = aws_iam_role.eks_node_group_role.arn
  subnet_ids      = aws_subnet.subnet_ids

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  instance_types = ["t2.medium"]

  tags = {
    Name = "JenkinsNodeGroup"
  }
}

# IAM role for the node group
resource "aws_iam_role" "eks_node_group_role" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# Define node group IAM policy
resource "aws_iam_role_policy" "eks_node_group_policy" {
  role   = aws_iam_role.eks_node_group_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "eks:DescribeNodegroup"
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

# Outputs
output "cluster_name" {
  value = aws_eks_cluster.eks-cluster.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.eks-cluster.endpoint
}

output "vpc_id" {
  value = aws_eks_cluster.eks-cluster.vpc_config[0].vpc_id
}

output "cluster_certificate_authority_data" {
  value = aws_eks_cluster.eks-cluster.certificate_authority[0].data
}

