# variables.tf

variable "AWS_REGION" {
  description = "The AWS region to deploy resources in"
  default     = "ap-south-1"
}

variable "subnet_ids" {
  description = "List of subnet IDs where the EKS nodes will be deployed"
  type        = list(string)
}

output "cluster_name" {
  value = aws_eks_cluster.cluster.name
}

output "node_group_name" {
  value = aws_eks_node_group.node_group.node_group_name
}

