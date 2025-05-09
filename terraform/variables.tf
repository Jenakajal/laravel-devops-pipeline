variable "eks_role_arn" {
  description = "IAM role ARN for EKS"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the EKS Cluster"
  type        = string
}

variable "desired_size" {
  description = "Desired number of nodes in the EKS Node Group"
  type        = number
}

variable "min_size" {
  description = "Minimum number of nodes in the EKS Node Group"
  type        = number
}

variable "max_size" {
  description = "Maximum number of nodes in the EKS Node Group"
  type        = number
}

