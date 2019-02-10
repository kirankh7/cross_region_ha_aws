resource "aws_security_group" "tier1" {
  vpc_id      = "${var.VPC_ID}"
  name        = "tier1-${var.ENV}"
  description = "security group that allows http and all egress traffic"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = ["${var.ALLOW_TIER2}"]
  }

  tags {
    Name         = "allow-con-from-tier2"
    Environmnent = "${var.ENV}"
  }
}
