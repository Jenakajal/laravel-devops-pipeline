variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "my-cluster"
}

variable "desired_size" {
  description = "The desired number of nodes in the EKS cluster"
  type        = number
  default     = 3
}

variable "min_size" {
  description = "The minimum number of nodes in the EKS cluster"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "The maximum number of nodes in the EKS cluster"
  type        = number
  default     = 5
}

variable "node_group_instance_types" {
  description = "The EC2 instance types for the EKS node group"
  type        = list(string)
  default     = ["t3.medium"]
}

# IAM role for EKS
variable "eks_role_arn" {
  description = "IAM role ARN for EKS"
  type        = string
}

# VPC configuration (if required)
variable "vpc_id" {
  description = "VPC ID for the EKS Cluster"
  type        = string
}

