# output.tf
output "eks_security_group_id" {
  value = aws_security_group.eks_worker_sec_group.id
}

output "eks_security_group_id_2" {
  value = aws_security_group.eks_worker_sec_group_2.id
}

output "eks_cluster_name" {
  value = module.eks.cluster_id
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}

