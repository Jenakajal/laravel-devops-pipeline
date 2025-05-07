variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1"
}

variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
  default     = "laravel-eks-cluster"
}

