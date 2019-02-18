output "allow-elb-traffic" {
  description = "Allows traffic from alb to target-group"
  value = "${aws_security_group.allow-http.id}"
}

output "target_group_name" {
  description = "Name of the target group. Useful for passing to your CodeDeploy Deployment Group."
  value       = "${module.alb.target_group_arns}"
}
output "alb1_dns_name" {
  value = "${module.alb.dns_name}"
}


output "alb_zone_id" {
  value = "${module.alb.load_balancer_zone_id}"
}