# provider.tf

provider "aws" {
  region = var.region
}

provider "aws" {
  alias  = "east"
  region = "us-east-1"  # Update if you need to use a different region for some resources
}

