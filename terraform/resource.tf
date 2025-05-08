resource "aws_security_group" "eks_worker_sec_group" {
  name_prefix   = "eks-worker-sec-group-"
  description   = "Allow access to EKS worker nodes"
  vpc_id        = module.vpc.vpc_id
  revoke_rules_on_delete = false

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

