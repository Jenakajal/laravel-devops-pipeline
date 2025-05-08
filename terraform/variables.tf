variable "region" {
  description = "AWS Region"
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "cluster_name" {
  description = "EKS cluster name"
  default     = "devops-eks-cluster"
}

variable "cluster_version" {
  description = "EKS cluster version"
  default     = "1.29"
}

variable "node_group_instance_types" {
  description = "List of instance types for node group"
  default     = ["t3.medium"]
}

variable "desired_size" {
  description = "Desired node group size"
  default     = 2
}

variable "min_size" {
  description = "Minimum node group size"
  default     = 1
}

variable "max_size" {
  description = "Maximum node group size"
  default     = 3
}

# Variable to define the name of the node group, for consistency
variable "node_group_name" {
  description = "Name of the EKS node group"
  default     = "jenkins_nodes"  # Updated to match the Jenkins node group name
}

