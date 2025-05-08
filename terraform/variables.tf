# Variable to set the name of the EKS cluster
variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "my-eks-cluster"  # Default name, change as needed
}

# Variable to define the VPC ID
variable "vpc_id" {
  description = "The VPC ID in which the EKS cluster will be created"
  type        = string
}

# Variable to define the subnets for the EKS cluster
variable "subnets" {
  description = "A list of subnet IDs for the EKS cluster"
  type        = list(string)
}

# Variable to set the region for AWS resources
variable "aws_region" {
  description = "The AWS region where resources will be provisioned"
  type        = string
  default     = "us-west-2"  # Change to the region you prefer
}

# Variable for the number of desired nodes in the EKS cluster
variable "node_group_desired_capacity" {
  description = "The desired capacity (number of nodes) for the EKS node group"
  type        = number
  default     = 2  # Default desired capacity, change as needed
}

# Variable for the maximum number of nodes in the EKS node group
variable "node_group_max_capacity" {
  description = "The maximum capacity (number of nodes) for the EKS node group"
  type        = number
  default     = 3  # Default maximum capacity, change as needed
}

# Variable for the minimum number of nodes in the EKS node group
variable "node_group_min_capacity" {
  description = "The minimum capacity (number of nodes) for the EKS node group"
  type        = number
  default     = 1  # Default minimum capacity, change as needed
}

# Variable for the EC2 instance type used in the EKS node group
variable "node_group_instance_type" {
  description = "The instance type for the EKS node group"
  type        = string
  default     = "t3.medium"  # Default instance type, change as needed
}

# Optional: Variable for SSH key pair to access EC2 instances in the node group
variable "key_name" {
  description = "The SSH key pair name to be used for EC2 instances in the node group"
  type        = string
  default     = ""  # Leave empty if no SSH key pair is used
}

