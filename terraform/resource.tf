# resource.tf
# Define security group rules or any other resources for your EKS cluster.

# Security group rules for the first security group
resource "aws_security_group_rule" "allow_ssh_access" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.eks_worker_sec_group.id
}

resource "aws_security_group_rule" "allow_http_access" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.eks_worker_sec_group.id
}

# Security group rules for the second security group
resource "aws_security_group_rule" "allow_ssh_access_2" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.eks_worker_sec_group_2.id
}

resource "aws_security_group_rule" "allow_http_access_2" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.eks_worker_sec_group_2.id
}

