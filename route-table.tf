# Create a resource block for the Route Table. This block creates a route table, associates it with the VPC, and creates a default route to the Internet Gateway.... where rtb = "route-table"
resource "aws_route_table" "project_rtb" {
  vpc_id                = aws_vpc.project_vpc.id

  route {
    cidr_block          = "0.0.0.0/0"
    gateway_id          = aws_internet_gateway.project_igw.id
  }

  tags = {
    Name        = "project_rtb"
  }
}

# Create a resource block for the Route Table Association. This block associates the subnets with the route table.... where rtb = "route-table-association"
resource "aws_route_table_association" "project_rtba1" {
  subnet_id             = aws_subnet.project_subnet1.id
  route_table_id        = aws_route_table.project_rtb.id
}

resource "aws_route_table_association" "project_rtba2" {
  subnet_id             = aws_subnet.project_subnet2.id
  route_table_id        = aws_route_table.project_rtb.id
}

resource "aws_route_table_association" "project_rtba3" {
  subnet_id             = aws_subnet.project_subnet3.id
  route_table_id        = aws_route_table.project_rtb.id
}



