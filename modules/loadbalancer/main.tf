resource "aws_lb" "lb" {
  name                       = var.project
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.sg.alb]
  subnets                    = var.public_subnets
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "lb_tg" {
  name     = var.lb_tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc.id

  health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "lb_tg_attachment" {
  target_group_arn = aws_lb_target_group.lb_tg.arn
  target_id        = var.web_instance
  port             = 80
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_tg.arn
  }
}
