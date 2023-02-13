# Create a resource block for the subnet. This block specifies the subnet details such as the CIDR block, the VPC ID, and the availability zone.
resource "aws_subnet" "project_subnet1" {
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.project_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-2a"

  tags = {
    Name                = "project_subnet1"
  }
}

resource "aws_subnet" "project_subnet2" {
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.project_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-west-2b"

  tags = {
    Name                = "project_subnet2"
  }
}

resource "aws_subnet" "project_subnet3" {
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.project_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "eu-west-2c"

  tags = {
    Name                = "project_subnet3"
  }
}