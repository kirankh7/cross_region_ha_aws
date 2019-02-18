//resource "aws_iam_role" "test_role" {
//  name = "ec2-reder-role-${terraform.workspace}"
//
//  assume_role_policy = <<EOF
//{
//    "Version": "2012-10-17",
//    "Statement": [
//        {
//            "Effect": "Allow",
//            "Action": "ec2:Describe*",
//            "Resource": "*"
//        },
//        {
//            "Effect": "Allow",
//            "Action": "elasticloadbalancing:Describe*",
//            "Resource": "*"
//        },
//        {
//            "Effect": "Allow",
//            "Action": [
//                "cloudwatch:ListMetrics",
//                "cloudwatch:GetMetricStatistics",
//                "cloudwatch:Describe*"
//            ],
//            "Resource": "*"
//        },
//        {
//            "Effect": "Allow",
//            "Action": "autoscaling:Describe*",
//            "Resource": "*"
//        }
//    ]
//}
//EOF
//
//  tags = {
//      tag-key = "tag-value-${terraform.workspace}"
//  }
//}
//
//resource "aws_iam_instance_profile" "read_access" {
//  name = "ec2-reder-${terraform.workspace}"
//  role = "${aws_iam_role.test_role.name}"
//}