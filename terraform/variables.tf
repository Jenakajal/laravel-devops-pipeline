variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_count" {
  description = "Number of public subnets"
  type        = number
  default     = 2
}

variable "eks_cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "eks-cluster"
}

variable "eks_cluster_role_name" {
  description = "IAM role for EKS cluster"
  type        = string
  default     = "eks-cluster-role"
}

variable "eks_node_role_name" {
  description = "IAM role for EKS node group"
  type        = string
  default     = "eks-node-role"
}

variable "eks_node_group_name" {
  description = "EKS node group name"
  type        = string
  default     = "eks-node-group"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

