variable "key_name" {
  description = "The EC2 Key Name to allow access to the EKS instances"
  type        = string
}

variable "region" {
  description = "AWS region"
  default     = "us-west-2"  # Adjust region accordingly
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

