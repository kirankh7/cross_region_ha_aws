resource "aws_s3_bucket" "alb_bucket" {
  bucket = "my-app-alb-logs"
  acl    = "private"
  force_destroy = true

  tags = {
    Name        = "MyFlaskApp"
    Environment = "${var.ENV}"
  }
  policy = <<POLICY
{
  "Id": "Policy1549739023698",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1549739021764",
      "Action": [
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::my-app-alb-logs/my-app-alb-logs/AWSLogs/352990902149/*",
      "Principal": {
        "AWS": [
          "156460612806"
        ]
      }
    }
  ]
}
POLICY
}