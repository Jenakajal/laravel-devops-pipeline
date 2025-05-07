output "cluster_name" {
  value = module.eks.cluster_name
}

output "kubeconfig" {
  value = module.eks.kubeconfig_filename
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

