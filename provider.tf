# This block specifies the details for the AWS provider and the region in which the EC2 instances, VPC and the ELB will be created.

provider "aws" {
  region = var.project_region
}

