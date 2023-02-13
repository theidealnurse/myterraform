# Create a resource block for the Internet Gateway. This block creates an Internet Gateway and attaches it to the VPC.
resource "aws_internet_gateway" "project_igw" {
  vpc_id                = aws_vpc.project_vpc.id

  tags = {
    Name                = "project_igw"
  }
}