resource "aws_lb_target_group_attachment" "attache_tier3" {
  count = "${var.INSTANCE_COUNT}"
  target_group_arn = "${var.TR_GROUP_NAME[0]}"
//  target_id        = "${element(split(",", aws_instance.instance_tier2.*.id), count.index)}"
  target_id = "${element(split(",", join(",", aws_instance.instance_tier3.*.id)), count.index)}"

//  port             = 80
}
//resource "aws_alb_target_group_attachment" "" {
//  target_group_arn = ""
//  target_id = ""
//}