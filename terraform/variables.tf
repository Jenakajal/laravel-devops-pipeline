# VPC Configuration
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Subnet Configuration
variable "subnet_cidr_block" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

# Node Group Configuration
variable "node_group_desired_size" {
  description = "The desired number of worker nodes in the node group"
  type        = number
  default     = 2
}

variable "node_group_min_size" {
  description = "The minimum number of worker nodes in the node group"
  type        = number
  default     = 1
}

variable "node_group_max_size" {
  description = "The maximum number of worker nodes in the node group"
  type        = number
  default     = 3
}

# Instance Type for the Worker Nodes
variable "instance_types" {
  description = "The EC2 instance types for the worker nodes"
  type        = list(string)
  default     = ["t3.medium"]
}

# Disk Size for EKS Node Group
variable "disk_size" {
  description = "The disk size for the worker nodes in GB"
  type        = number
  default     = 20
}

# Region for AWS
variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

