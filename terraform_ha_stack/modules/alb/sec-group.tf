resource "aws_security_group" "allow-http" {
  vpc_id      = "${var.VPC_ID}"
  name        = "allow-http-${var.ENV}"
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
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name         = "allow-traffic-in"
    Environmnent = "${var.ENV}"
  }
}

resource "aws_security_group" "allow-group" {
  vpc_id      = "${var.VPC_ID}"
  name        = "allow-group-${var.ENV}"
  description = "security group that allows http and all egress traffic"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name         = "allow-ssh"
    Environmnent = "${var.ENV}"
  }
}