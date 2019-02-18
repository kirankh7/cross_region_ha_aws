resource "aws_instance" "instance_tier2" {
  count         = "${var.INSTANCE_COUNT}"
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "${var.INSTANCE_TYPE}"
  subnet_id = "${element(var.PUBLIC_SUBNETS,count.index)}"
  vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}","${aws_security_group.tier2.id}"]
  key_name = "${aws_key_pair.my_pub_keypair.key_name}"

  # Customs
//  user_data = "${data.template_cloudinit_config.cloudinit-example.rendered}"
  iam_instance_profile = "${aws_iam_instance_profile.reader_profile.name}"

  tags {
    Name         = "instance-tier2-${var.ENV}"
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
      "sh /tmp/chef/install_tier2.sh",
    ]


  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = "${file("${path.root}/${var.PATH_TO_PRIVATE_KEY}")}"

  }
  }
  tags {
    Name= "${var.TIER_2_INSTANCE_NAME}-${count.index+1}"
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
