# Output the EKS Cluster Name
output "eks_cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
  description = "The name of the EKS cluster."
}

# Output the EKS Cluster Endpoint (API URL)
output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
  description = "The API endpoint URL for the EKS cluster."
}

# Output the EKS Cluster ARN
output "eks_cluster_arn" {
  value = aws_eks_cluster.eks_cluster.arn
  description = "The ARN of the EKS cluster."
}

# Output the EKS Cluster Role ARN
output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
  description = "The ARN of the EKS cluster IAM role."
}

# Output the Node Group ID
output "eks_node_group_id" {
  value = aws_eks_node_group.eks_node_group.id
  description = "The ID of the EKS node group."
}

# Output the Node Group Name
output "eks_node_group_name" {
  value = aws_eks_node_group.eks_node_group.node_group_name
  description = "The name of the EKS node group."
}

# Output the Node Group IAM Role ARN
output "eks_node_group_role_arn" {
  value = aws_iam_role.eks_node_group_role.arn
  description = "The ARN of the IAM role used by the EKS node group."
}

# Output the EKS Node Group Instance Types
output "eks_node_group_instance_types" {
  value = aws_eks_node_group.eks_node_group.instance_types
  description = "The instance types used for the EKS node group."
}

# Output the VPC CIDR Block
output "vpc_cidr_block" {
  value = aws_vpc.eks_vpc.cidr_block
  description = "The CIDR block for the VPC."
}

# Output the VPC ID
output "vpc_id" {
  value = aws_vpc.eks_vpc.id
  description = "The ID of the VPC."
}

# Output the Public Subnet IDs
output "public_subnet_ids" {
  value = aws_subnet.eks_public_subnets[*].id
  description = "The IDs of the public subnets."
}

# Output the Private Subnet IDs
output "private_subnet_ids" {
  value = aws_subnet.eks_private_subnets[*].id
  description = "The IDs of the private subnets."
}

# Output the Security Group ID for EKS Nodes
output "eks_sg_id" {
  value = aws_security_group.eks_sg.id
  description = "The ID of the security group associated with the EKS nodes."
}

# Output the EKS Cluster Kubeconfig Command
output "kubeconfig_command" {
  value = "aws eks --region ${var.aws_region} update-kubeconfig --name ${aws_eks_cluster.eks_cluster.name}"
  description = "The command to update the kubeconfig for accessing the EKS cluster."
}


