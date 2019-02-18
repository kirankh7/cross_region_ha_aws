resource "aws_iam_role" "reader_role" {
  name = "test-role-${terraform.workspace}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
      tag-key = "tag-value"
  }
}

resource "aws_iam_policy" "read_policy" {
  name        = "read-policy-${terraform.workspace}"
  path        = "/"
  description = "read-only"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "ec2:Describe*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "elasticloadbalancing:Describe*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "cloudwatch:ListMetrics",
                "cloudwatch:GetMetricStatistics",
                "cloudwatch:Describe*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "autoscaling:Describe*",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_policy_attachment" "reader_attach" {
  name       = "reader-pol-attachment-${terraform.workspace}"
  roles      = ["${aws_iam_role.reader_role.name}"]
  policy_arn = "${aws_iam_policy.read_policy.arn}"
}


resource "aws_iam_instance_profile" "reader_profile" {
  name = "reader-profile-${terraform.workspace}"
  role = "${aws_iam_role.reader_role.name}"
}

# attache