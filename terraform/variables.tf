# Declare the VPC CIDR block
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Declare the count for public subnets
variable "public_subnet_count" {
  description = "The number of public subnets to create"
  type        = number
  default     = 2
}

# Declare the name of the EKS cluster
variable "eks_cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "eks-cluster"
}

# Declare the name of the EKS cluster role
variable "eks_cluster_role_name" {
  description = "The name of the EKS cluster role"
  type        = string
  default     = "eks-cluster-role"
}

# Declare the name of the EKS node role
variable "eks_node_role_name" {
  description = "The name of the EKS node role"
  type        = string
  default     = "eks-node-role"
}

# Declare the name of the EKS node group
variable "eks_node_group_name" {
  description = "The name of the EKS node group"
  type        = string
  default     = "eks-node-group"
}

# Declare the AWS region to deploy resources
variable "region" {
  description = "The AWS region to deploy the resources"
  type        = string
  default     = "us-west-2"
}

