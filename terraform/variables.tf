# Variable for VPC CIDR Block
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Variable for the number of public subnets
variable "public_subnet_count" {
  description = "Number of public subnets to create"
  type        = number
  default     = 2
}

# Variable for the EKS Cluster name
variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "eks-cluster"
}

# Variable for the EKS Cluster IAM Role name
variable "eks_cluster_role_name" {
  description = "Name for the EKS Cluster IAM Role"
  type        = string
  default     = "eks-cluster-role"
}

# Variable for the EKS Node IAM Role name
variable "eks_node_role_name" {
  description = "Name for the EKS Node IAM Role"
  type        = string
  default     = "eks-node-role"
}

# Variable for the EKS Node Group name
variable "eks_node_group_name" {
  description = "Name for the EKS Node Group"
  type        = string
  default     = "eks-node-group"
}

