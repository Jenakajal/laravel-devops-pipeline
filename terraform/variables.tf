# AWS Region
variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-west-2"  # Update region as per your preference
}

# VPC Configuration
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Subnet CIDR Blocks for Public Subnets
variable "subnet_cidr" {
  description = "The CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# EKS Cluster Configuration
variable "eks_cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "devops-eks-cluster"
}

variable "eks_version" {
  description = "The version of the EKS cluster"
  type        = string
  default     = "1.21"
}

# EC2 Node Configuration for EKS
variable "node_instance_type" {
  description = "The EC2 instance type for the EKS node group"
  type        = string
  default     = "t3.medium"
}

variable "node_count" {
  description = "The number of nodes in the EKS node group"
  type        = number
  default     = 2
}

# AMI ID for EC2 instances in the node group
variable "ami_id" {
  description = "The AMI ID for the EC2 instances in the node group"
  type        = string
  default     = ""  # Replace with actual AMI ID for your EC2 node instances
}

# IAM Role Names
variable "eks_cluster_role_name" {
  description = "The IAM role name for the EKS cluster"
  type        = string
  default     = "eks-cluster-role"
}

variable "eks_node_role_name" {
  description = "The IAM role name for the EKS node group"
  type        = string
  default     = "eks-node-role"
}

# IAM Role Policies to Attach to EKS Cluster and Node Roles
variable "iam_policy_names" {
  description = "The IAM policies to be attached to the roles"
  type        = list(string)
  default     = ["AmazonEKSClusterPolicy", "AmazonEKSWorkerNodePolicy", "AmazonEC2ContainerRegistryReadOnly"]
}

# EKS Node Group IAM Policies
variable "node_group_policies" {
  description = "List of IAM policies to be attached to the node group role"
  type        = list(string)
  default     = ["AmazonEKSWorkerNodePolicy", "AmazonEC2ContainerRegistryReadOnly"]
}

# Security Group Configuration for EKS Cluster
variable "security_group_ids" {
  description = "Security group IDs to attach to the EKS cluster"
  type        = list(string)
  default     = []  # Modify as needed, or use a custom security group
}

# Kubernetes Cluster Settings
variable "cluster_endpoint_public_access" {
  description = "Enable public access to the EKS cluster endpoint"
  type        = bool
  default     = true
}

variable "cluster_endpoint_private_access" {
  description = "Enable private access to the EKS cluster endpoint"
  type        = bool
  default     = false
}

