output "tier3_instance_id" {
  description = "instance ids"
  value = "${aws_instance.instance_tier3.id}"
}

output "tier2_instance_id" {
  description = "instance ids"
  value = "${aws_instance.instance_tier2.id}"
}

