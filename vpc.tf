# Create a resource block for the VPC. This block specifies the VPC details such as the CIDR block, the number of availability zones, etc.
resource "aws_vpc" "project_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "project_vpc"
  }
}