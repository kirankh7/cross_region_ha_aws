resource "aws_instance" "instance_tier2" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "${var.INSTANCE_TYPE}"
  subnet_id = "${var.PUBLIC_SUBNETS[0]}"
  vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}","${aws_security_group.tier2.id}"]
  key_name = "${aws_key_pair.my_pub_keypair.key_name}"
  tags {
    Name         = "instance-tier2-${var.ENV}"
    Environmnent = "${var.ENV}"
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
      "sh /tmp/chef/install.sh",
    ]


  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = "${file("${path.root}/${var.PATH_TO_PRIVATE_KEY}")}"

  }
  }
}

resource "aws_key_pair" "my_pub_keypair" {
  key_name   = "mykeypair-pub-${var.ENV}"
  public_key = "${file("${path.root}/${var.PATH_TO_PUBLIC_KEY}")}"
}

//resource "aws_key_pair" "my_priv_keypair" {
//  key_name   = "mykeypair-priv-${var.ENV}"
//  public_key = "${file("${path.root}/${var.PATH_TO_PRIVATE_KEY}")}"
//}
