provider "aws" {
  region = "us-west-2"  # Adjust your region accordingly
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "eks-vpc"
  cidr   = "10.0.0.0/16"
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "my-eks-cluster"
  cluster_version = "1.21"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id
  node_group_defaults = {
    instance_type = "t2.micro"
    min_size      = 1
    max_size      = 3
  }
  node_groups = {
    eks_nodes = {
      desired_size = 2
      instance_type = "t2.micro"
      key_name      = var.key_name
    }
  }

  # ENI Plugin (VPC CNI) settings
  enable_vpc_cni = true
}

# Security group for worker nodes
resource "aws_security_group" "eks_worker_sec_group" {
  name_prefix            = "eks-worker-"
  description            = "Allow access to EKS worker nodes"
  vpc_id                 = module.vpc.vpc_id
  revoke_rules_on_delete = false

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

resource "aws_iam_role" "eks_role" {
  name = "eks-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "eks_node_policy" {
  name   = "eks-node-policy"
  role   = aws_iam_role.eks_role.name
  policy = data.aws_iam_policy_document.eks_node_policy_document.json
}

data "aws_iam_policy_document" "eks_node_policy_document" {
  statement {
    actions   = ["ec2:DescribeInstances", "ec2:DescribeVolumes", "ec2:AttachVolume"]
    resources = ["*"]
  }
}

resource "aws_security_group" "eks_sec_group" {
  name_prefix   = "eks-sec-group-"
  description   = "Allow access to EKS Cluster"
  vpc_id        = module.vpc.vpc_id
  revoke_rules_on_delete = false

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

