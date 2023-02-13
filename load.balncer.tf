#Create a resource block for the Load Balancer.

resource "aws_lb" "project_lb" {
  name               = "project-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.project_alb_sg.id]
  subnets            = [aws_subnet.project_subnet1.id, aws_subnet.project_subnet2.id, aws_subnet.project_subnet3.id]


#enable_cross_zone_load_balancing = true
 
  enable_deletion_protection = false
}