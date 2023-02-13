# Create target groups for the load balancer.. where tg = target group

resource "aws_lb_target_group" "project_tg" {
  name     = "project-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.project_vpc.id

  health_check {
    port                = 80
    protocol            = "HTTP"
    path                = "/"
    matcher             = "200-299"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

# Attach target groups to load balancer

resource "aws_lb_target_group_attachment" "project_tg_attachment1" {
  target_group_arn = aws_lb_target_group.project_tg.arn
  target_id = aws_instance.project_in1.id
  port = 80
}

resource "aws_lb_target_group_attachment" "project_tg_attachment2" {
  target_group_arn = aws_lb_target_group.project_tg.arn
  target_id = aws_instance.project_in2.id
  port = 80
}

resource "aws_lb_target_group_attachment" "project_tg_attachment3" {
  target_group_arn = aws_lb_target_group.project_tg.arn
  target_id = aws_instance.project_in3.id
  port = 80
}

