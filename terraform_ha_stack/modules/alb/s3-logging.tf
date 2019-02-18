resource "aws_s3_bucket" "alb_bucket" {
  bucket = "my-app-alb-logs-${terraform.workspace}"
  acl    = "private"
  force_destroy = true

  tags = {
    Name        = "MyFlaskApp"
    Environment = "${terraform.workspace}"
  }
  policy = <<POLICY
{
  "Id": "Policy1550471927870",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1550471917472",
      "Action": [
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::my-app-alb-logs-${terraform.workspace}/my-app-alb-logs/AWSLogs/352990902149/*",
      "Principal": {
        "AWS": [
          "${var.LOG_REGION_ID}"
        ]
      }
    }
  ]
}
POLICY
}

