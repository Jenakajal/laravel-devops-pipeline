# Outputs for EKS Cluster and Node Group
output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.name
}

output "eks_cluster_endpoint" {
  description = "The endpoint URL of the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_cluster_arn" {
  description = "The ARN of the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.arn
}

output "node_group_name" {
  description = "The name of the EKS node group"
  value       = aws_eks_node_group.node_group.node_group_name
}

output "node_group_status" {
  description = "The status of the EKS node group"
  value       = aws_eks_node_group.node_group.status
}

output "worker_node_role_arn" {
  description = "The ARN of the IAM role associated with the worker nodes"
  value       = aws_iam_role.eks_node_role.arn
}

output "vpc_id" {
  description = "The ID of the VPC where the EKS cluster is deployed"
  value       = aws_vpc.eks_vpc.id
}

output "subnet_ids" {
  description = "The IDs of the subnets associated with the EKS cluster"
  value       = aws_subnet.eks_subnet.id
}

