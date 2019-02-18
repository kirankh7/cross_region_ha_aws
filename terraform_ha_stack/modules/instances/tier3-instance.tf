resource "aws_instance" "instance_tier3" {
  count         = "${var.INSTANCE_COUNT}"
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "${var.INSTANCE_TYPE}"
  subnet_id = "${element(var.PUBLIC_SUBNETS,count.index)}" #["${var.PUBLIC_SUBNETS}"]
  vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}","${aws_security_group.tier3.id}"]
  key_name = "${aws_key_pair.my_pub_keypair.key_name}"
  tags {
    Name         = "instance-tier3-${var.ENV}"
    Environmnent = "${var.ENV}"
  }
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = "${file("${path.root}/${var.PATH_TO_PRIVATE_KEY}")}"

  }

//  provisioner "file" {
//    source = "${data.template_file.init.rendered}"
//    destination = "/var/kiran"
//  }
//  provisioner "local-exec" {
//    command = 'echo "${join(",", aws_instance.instance_tier2.*.private_ip)}" > /newfileip'
//  }

  provisioner "file" {
    # Referencing the template_dir resource ensures that it will be
    # created or updated before this aws_instance resource is provisioned.
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
  user_data = "${data.template_cloudinit_config.cloudinit-example.rendered}"
}