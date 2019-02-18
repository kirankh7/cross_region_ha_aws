resource "aws_security_group" "allow-ssh" {
  vpc_id      = "${var.VPC_ID}"
  name        = "allow-ssh-${var.ENV}"
  description = "security group that allows ssh and all egress traffic"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name         = "allow-ssh"
    Environmnent = "${var.ENV}"
  }
}

//resource "aws_security_group" "allow_all_alb" {
//  name        = "allow_all_alb"
//  description = "Allow all inbound traffic"
//  vpc_id      = "${var.VPC_ID}"
//
//  ingress {
//    from_port   = 80
//    to_port     = 80
//    protocol    = "-1"
//    cidr_blocks = ["10.0.0.0/16"]
//  }
//
//  egress {
//    from_port       = 0
//    to_port         = 0
//    protocol        = "tcp"
//    cidr_blocks     = ["0.0.0.0/0"]
//  }
//}


resource "aws_security_group" "tier3" {
  vpc_id      = "${var.VPC_ID}"
  name        = "tier3-${var.ENV}"
  description = "security group that allows http and all egress traffic"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = ["${var.ALB_SEC_GROUP}"]
  }

  tags {
    Name         = "allow-http"
    Environmnent = "${var.ENV}"
  }
}

resource "aws_security_group" "tier2" {
  vpc_id      = "${var.VPC_ID}"
  name        = "tier2-${var.ENV}"
  description = "security group that allows http and all egress traffic"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    security_groups = ["${aws_security_group.tier3.id}"]
  }

  tags {
    Name         = "allow-all-from-tier3"
    Environmnent = "${var.ENV}"
  }
}

output "tier2_sec_group" {
  description = "This allow all connection to port 3306 from tier-2 machines"
  value = "${aws_security_group.tier2.id}"
}