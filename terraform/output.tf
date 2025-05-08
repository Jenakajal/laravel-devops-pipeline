output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_kubeconfig" {
  description = "Command to update local kubeconfig for EKS"
  value       = "aws eks --region ${var.aws_region} update-kubeconfig --name ${module.eks.cluster_name}"
  sensitive   = true
}

output "eks_node_group_name" {
  description = "Name of the EKS managed node group"
  value       = module.eks.eks_managed_node_groups["eks_nodes"].name
}

