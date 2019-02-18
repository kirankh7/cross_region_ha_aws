data "aws_route53_zone" "selected" {
  name         = "thebetterengineers.com"
//  private_zone = true
}

resource "aws_route53_record" "reg1" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name    = "flaskapp"
  type    = "A"

  weighted_routing_policy {
    weight = "${var.REGION_WAIT}"
  }
  set_identifier = "${var.AWS_REGION}"

  alias {
    name                   = "${var.ALB1}"
    zone_id                = "${var.ALB_ZONE_ID}"
    evaluate_target_health = true
  }
}

# Change it to 200 OK later
//resource "null_resource" "example" {
//  depends_on = []
//  provisioner "local-exec" {
//    command = "sleep 420; python -mwebbrowser -t http://${aws_route53_record.reg1.name}.thebetterengineers.com"
////    interpreter = ["python"]
//  }
//}
//
//resource "aws_route53_record" "reg2" {
//  zone_id = "${data.aws_route53_zone.selected.zone_id}"
//  name    = "flaskapp"
//  type    = "A"
//
//  weighted_routing_policy {
//    weight = 20
//  }
//
//  alias {
//    name                   = "${var.ALB1}"
//    zone_id                = "${data.aws_route53_zone.selected.zone_id}"
//    evaluate_target_health = true
//  }
//}



//
//resource "aws_route53_record" "www-reg1" {
//  zone_id = "${data.aws_route53_zone.selected.zone_id}"
//  name    = "@"
//  type    = "A"
//  ttl     = "5"
//
//  weighted_routing_policy {
//    weight = 10
//  }
//
//  set_identifier = "${var.AWS_REGION}"
//  records        = ["${var.ALB1}"]
//}
//
//resource "aws_route53_record" "www-reg2" {
//  zone_id = "${data.aws_route53_zone.selected.zone_id}"
//  name    = "@"
//  type    = "A"
//  ttl     = "5"
//
//  weighted_routing_policy {
//    weight = 90
//  }
//
//  set_identifier = "secondry"
//  records        = ["live.example.com"]
//}


//resource "aws_route53_health_check" "example" {
//  fqdn              = "example.com"
//  port              = 80
//  type              = "HTTP"
//  resource_path     = "/"
//  failure_threshold = "5"
//  request_interval  = "30"
//
//  tags = {
//    Name = "tf-test-health-check"
//  }
//}