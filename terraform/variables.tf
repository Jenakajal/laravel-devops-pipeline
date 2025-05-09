# Variable for IAM Role ARN for EKS
variable "eks_role_arn" {
  description = "IAM role ARN for EKS"
  type        = string
  # Replace with actual ARN or provide this value during plan/apply
  default     = "arn:aws:iam::123456789012:role/eks-role"  # Example ARN, replace with actual value
}

# Variable for VPC ID
variable "vpc_id" {
  description = "VPC ID for the EKS Cluster"
  type        = string
  # Replace with actual VPC ID or provide this value during plan/apply
  default     = "vpc-12345678"  # Example VPC ID, replace with actual value
}

# Variables for EKS Node Group Size
variable "desired_size" {
  description = "Desired number of nodes in the EKS Node Group"
  type        = number
  default     = 3  # Adjust according to your requirements
}

variable "min_size" {
  description = "Minimum number of nodes in the EKS Node Group"
  type        = number
  default     = 1  # Adjust according to your requirements
}

variable "max_size" {
  description = "Maximum number of nodes in the EKS Node Group"
  type        = number
  default     = 5  # Adjust according to your requirements
}

