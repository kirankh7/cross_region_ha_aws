resource "template_dir" "config" {
  source_dir      = "${path.module}/instance_config_templates"
  destination_dir = "${path.cwd}/instance_config"
  vars = {
    tier2_private_ip = "${aws_instance.instance_tier2.private_ip}"
  }
}
