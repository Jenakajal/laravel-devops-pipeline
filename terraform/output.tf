# outputs.tf

output "cluster_name" {
  description = "The name of the EKS cluster."
  value       = aws_eks_cluster.eks_cluster.name
}

output "cluster_endpoint" {
  description = "The endpoint of the EKS cluster."
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_arn" {
  description = "The ARN of the EKS cluster."
  value       = aws_eks_cluster.eks_cluster.arn
}

output "node_group_name" {
  description = "The name of the node group."
  value       = aws_eks_node_group.node_group.node_group_name
}

output "node_group_status" {
  description = "The status of the node group."
  value       = aws_eks_node_group.node_group.status
}

output "node_group_instance_types" {
  description = "The instance types of the EKS worker nodes."
  value       = aws_eks_node_group.node_group.instance_types
}

