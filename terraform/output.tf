output "eks_cluster_name" {
  description = "EKS Cluster Name"
  value       = module.eks.cluster_id
}

output "eks_cluster_endpoint" {
  description = "EKS Cluster API endpoint"
  value       = module.eks.cluster_endpoint
}

output "eks_node_group_name" {
  description = "EKS Node Group Name"
  value       = module.eks.node_groups["eks_nodes"].id
}

output "eks_node_group_role" {
  description = "EKS Node Group Role ARN"
  value       = aws_iam_role.eks_role.arn
}

output "eks_cluster_security_group" {
  description = "EKS Cluster Security Group"
  value       = aws_security_group.eks_worker_sec_group.id
}

