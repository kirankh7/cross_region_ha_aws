module "alb" {
  source                        = "terraform-aws-modules/alb/aws"
  load_balancer_name            = "my-app-alb"
  security_groups               = ["${aws_security_group.allow-http.id}", "${aws_security_group.allow-group.id}"]
  log_bucket_name               = "${aws_s3_bucket.alb_bucket.id}"
  log_location_prefix           = "my-app-alb-logs"
  subnets                       = "${var.PUBLIC_SUBNETS}"
  tags                          = "${map("Environment", "test")}"
  vpc_id                        = "${var.VPC_ID}"
//  https_listeners               = "${list(map("certificate_arn", "arn:aws:iam::123456789012:server-certificate/test_cert-123456789012", "port", 443))}"
//  https_listeners_count         = "1"
  http_tcp_listeners            = "${list(map("port", "80", "protocol", "HTTP"))}"
  http_tcp_listeners_count      = "1"
  target_groups                 = "${list(map("name", "flask-app-tg", "backend_protocol", "HTTP", "backend_port", "80"))}"
  target_groups_count           = "1"
}
