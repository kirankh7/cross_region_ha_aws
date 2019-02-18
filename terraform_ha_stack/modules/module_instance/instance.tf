module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "1.12.0"

  name                   = "my-flask-cluster"
  instance_count         = 5

  ami                    = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type          = "t2.micro"
  key_name               = "${aws_key_pair.my_pub_keypair.key_name}"
  monitoring             = true
  vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}","${aws_security_group.tier2.id}"]
  subnet_id              = "${element(var.PUBLIC_SUBNETS,count.index)}"

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

resource "aws_key_pair" "my_pub_keypair" {
  key_name   = "mykeypair-pub-${var.ENV}"
  public_key = "${file("${path.root}/${var.PATH_TO_PUBLIC_KEY}")}"
}