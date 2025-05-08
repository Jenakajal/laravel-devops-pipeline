module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.13.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  subnet_ids = module.vpc.private_subnets
  vpc_id     = module.vpc.vpc_id

  eks_managed_node_groups = {
  eks_nodes = {
    instance_types = var.node_group_instance_types
    desired_size   = var.desired_size
    min_size       = var.min_size
    max_size       = var.max_size
  }
}

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "kubeconfig" {
  value     = module.eks.kubeconfig
  sensitive = true
}
}

output "vpc_id" {
  value = module.vpc.vpc_id
}


