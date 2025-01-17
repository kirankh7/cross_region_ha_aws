resource "aws_instance" "instance_tier3" {
  count         = "${var.INSTANCE_COUNT}"
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "${var.INSTANCE_TYPE}"
  subnet_id = "${element(var.PUBLIC_SUBNETS,count.index)}" #["${var.PUBLIC_SUBNETS}"]
  vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}","${aws_security_group.tier3.id}"]
  key_name = "${aws_key_pair.my_pub_keypair.key_name}"

  # Customs
  user_data = "${data.template_cloudinit_config.cloudinit-example.rendered}"
//  iam_instance_profile = "${aws_iam_instance_profile.reader_profile.name}"

  tags {
    Name         = "instance-tier3-${var.ENV}"
    Environmnent = "${var.ENV}"
  }
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = "${file("${path.root}/${var.PATH_TO_PRIVATE_KEY}")}"

  }

  provisioner "file" {
    source      = "${template_dir.config.destination_dir}"
    destination = "/tmp/instance_config"
  }

  provisioner "file" {
  source      = "${path.module}/scripts/chef"
  destination = "/tmp/chef"

  }

  provisioner "remote-exec" {
    inline = [
      "sh /tmp/chef/install_tier3_nginx.sh",
    ]
  }

  tags {
    Name= "${var.TIER_3_INSTANCE_NAME}-${count.index+1}"
  }
}