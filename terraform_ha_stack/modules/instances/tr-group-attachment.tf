resource "aws_lb_target_group_attachment" "attache_tier3" {
  target_group_arn = "${var.TR_GROUP_NAME[0]}"
  target_id        = "${element(aws_instance.instance_tier2.*.id, count.index)}"
  port             = 80
}