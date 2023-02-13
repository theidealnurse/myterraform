# Create a security group for application load balancer.. where alb = application load balancer and sg is security group
resource "aws_security_group" "project_alb_sg" {
  name                  = "project_alb_sg"
  description           = "Allow HTTPS and HTTP inbound traffic for application load balancer"
  vpc_id                = aws_vpc.project_vpc.id

  dynamic "ingress" {
    for_each            = var.inbound_ports

    content {
      from_port         = ingress.value
      to_port           = ingress.value
      protocol          = "tcp"
      cidr_blocks       = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

# Create security group for instances...
resource "aws_security_group" "project_instance_sg" {
  name                  = "project_instance_sg"
  description           = "Allow HTTPS and HTTP inbound traffic for the instances"
  vpc_id                = aws_vpc.project_vpc.id

  dynamic "ingress" {
    for_each            = var.inbound_ports

    content {
      from_port         = ingress.value
      to_port           = ingress.value
      protocol          = "tcp"
      security_groups   = [aws_security_group.project_alb_sg.id]
    }
  }

  ingress {
    description         = "Allow SSH"
    from_port           = 22
    to_port             = 22
    protocol            = "tcp"
    cidr_blocks         = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "project_instance_sg"
  }

}