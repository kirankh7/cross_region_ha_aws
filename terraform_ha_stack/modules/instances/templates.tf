resource "template_dir" "config" {
  source_dir      = "${path.module}/instance_config_templates"
  destination_dir = "${path.module}/scripts/chef/terra_templates"
//  instance_count = "${length(aws_instance.instance_tier2.*.private_ip)}"
  vars = {
//    tier2_private_ip = "${join("",aws_instance.instance_tier2.*.private_ip)}"
    database_endpoint = "${var.DB_ENDPOINT}"
    database_name = "${var.DB_NAME}"
    database_user_name = "${var.DB_USERNAME}"
    database_password = "${var.DB_PASSWORD}"
  }
}

//data "template_file" "example" {
//  template = "$${hello} $${world}!"
//  vars {
//    hello = "goodnight"
//    world = "moon"
//  }
//}
//
//output "rendered" {
//  value = "${data.template_file.example.rendered}"
//}

data "template_file" "init" {
  template = "${file("${path.module}/init.tpl")}"
  vars = {
    consul_address = "${join(",",aws_instance.instance_tier2.*.private_ip)}"
  }
}