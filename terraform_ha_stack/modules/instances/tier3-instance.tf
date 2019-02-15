resource "aws_instance" "instance_tier3" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "${var.INSTANCE_TYPE}"
  subnet_id = "${var.PUBLIC_SUBNETS[0]}"
  vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}","${aws_security_group.tier3.id}"]
  key_name = "${aws_key_pair.my_pub_keypair.key_name}"
  tags {
    Name         = "instance-tier3-${var.ENV}"
    Environmnent = "${var.ENV}"
  }
  provisioner "file" {
    # Referencing the template_dir resource ensures that it will be
    # created or updated before this aws_instance resource is provisioned.
    source      = "${template_dir.config.destination_dir}"
    destination = "/tmp/instance_config"

  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = "${file("${path.root}/${var.PATH_TO_PRIVATE_KEY}")}"

  }
  }
  provisioner "file" {
  source      = "${path.module}/scripts/chef"
  destination = "/tmp/chef"

  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = "${file("${path.root}/${var.PATH_TO_PRIVATE_KEY}")}"

  }
}
  provisioner "remote-exec" {
    inline = [
      "sh /tmp/chef/install_tier3_nginx.sh",
    ]

  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = "${file("${path.root}/${var.PATH_TO_PRIVATE_KEY}")}"

  }
  }
}