output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_arn" {
  value = module.eks.cluster_arn
}

output "node_group_name" {
  value = module.eks.node_groups["eks_nodes"].node_group_name
}

output "node_group_status" {
  value = module.eks.node_groups["eks_nodes"].status
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_ids" {
  value = module.vpc.private_subnets
}

