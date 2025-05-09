# Region for AWS provider
variable "region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-east-1"  # Update this to the region you want
}

# VPC CIDR block for your VPC
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"  # Change it to your desired CIDR block
}

# Private subnets for the VPC (two private subnets, adjust according to your requirements)
variable "private_subnets" {
  description = "Private subnets CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]  # Update with your subnet CIDR blocks
}

# Public subnets for the VPC
variable "public_subnets" {
  description = "Public subnets CIDR blocks"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]  # Update with your subnet CIDR blocks
}

# Node Group Instance Types (Update based on your preferred EC2 instance type)
variable "node_group_instance_types" {
  description = "EC2 instance types for the EKS node group"
  type        = list(string)
  default     = ["t3.medium"]  # Update with your preferred instance type
}

# Desired size of the EKS node group
variable "desired_size" {
  description = "Desired number of nodes in the EKS node group"
  type        = number
  default     = 2  # Update with the desired number of nodes
}

# Minimum size of the EKS node group
variable "min_size" {
  description = "Minimum number of nodes in the EKS node group"
  type        = number
  default     = 1  # Update as needed
}

# Maximum size of the EKS node group
variable "max_size" {
  description = "Maximum number of nodes in the EKS node group"
  type        = number
  default     = 3  # Update as needed
}

# EKS Cluster name
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "eks-cluster"  # You can change this to your preferred cluster name
}

