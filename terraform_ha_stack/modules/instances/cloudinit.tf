
data "template_file" "init-script" {
  template = "${file("${path.module}/scripts/init.cfg")}"
  vars {
    REGION = "${var.AWS_REGION}"
    IPLIST =  "${join(" ",aws_instance.instance_tier2.*.private_ip)}"
  }
}


data "template_cloudinit_config" "cloudinit-example" {

  gzip = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = "${data.template_file.init-script.rendered}"
  }
//
//  part {
//    content_type = "text/x-shellscript"
//    content      = "${data.template_file.shell-script.rendered}"
//  }

}