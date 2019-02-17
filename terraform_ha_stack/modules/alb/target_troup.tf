//resource "aws_alb_target_group" "vmm-alb" {
//  lifecycle {
//    create_before_destroy = true
//  }
//  name     = "${var.ENV}-flask-app"
//  port     = 8000
//  protocol = "HTTP"
//  vpc_id   = "${var.VPC_ID}"
//  health_check {
//    healthy_threshold   = 2
//    unhealthy_threshold = 2
//    timeout             = 3
//    path                = "/health"
//    interval            = 30
//  }
//}
//
