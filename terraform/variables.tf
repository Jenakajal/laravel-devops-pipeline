# variables.tf

variable "AWS_REGION" {
  description = "The AWS region to deploy resources in"
  default     = "ap-south-1"
}

variable "subnet_ids" {
  description = "List of subnet IDs where the EKS nodes will be deployed"
  type        = list(string)
}
`
