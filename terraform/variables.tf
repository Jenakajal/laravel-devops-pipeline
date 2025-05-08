# Variable for VPC ID
variable "vpc_id" {
  description = "VPC ID for the EKS Cluster"
  type        = string
  default     = "vpc-xxxxxxxx"  # Replace with your actual VPC ID
}

# Variable for Subnets
variable "subnets" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
  default     = [
    "subnet-xxxxxxxx",  # Replace with your actual subnet IDs
    "subnet-yyyyyyyy"
  ]
}

# Variable for Cluster Name
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "my-eks-cluster"  # Replace with your desired EKS cluster name
}

