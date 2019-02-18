//data "aws_caller_identity" "current" {}
//
//
//
//# primary to secondry
//resource "aws_vpc_peering_connection" "primary2secondary" {
//  peer_owner_id = "${data.aws_caller_identity.current.account_id}"
//  peer_vpc_id = "${module.main-vpc.vpc_id}" # vpc from us-east-region
//  vpc_id = "${aws_vpc.primary.id}"  # vpc from eu-region
////  peer_region = ""
//  auto_accept = true
//
//  tags = {
//    Name = "VPC Peering between Primary and Secondry"
//  }
//}
//
//
//
//
//
//resource "aws_route" "primary2secondary" {
//  route_table_id = "${aws_route_table.prim-main-public.id}"
////  route_table_id = "${aws_vpc.primary.main_route_table_id}"
//  destination_cidr_block = "${aws_vpc.secondary.cidr_block}"
//  vpc_peering_connection_id = "${aws_vpc_peering_connection.primary2secondary.id}"
//}
//
//resource "aws_route" "secondary2primary" {
////  route_table_id = "${aws_vpc.secondary.main_route_table_id}"
//  route_table_id = "${aws_route_table.sec-main-public.id}"
//  destination_cidr_block = "${aws_vpc.primary.cidr_block}"
//  vpc_peering_connection_id = "${aws_vpc_peering_connection.primary2secondary.id}"
//}
//
//
//resource "aws_db_instance" "default" {
//  identifier = "${var.identifier}"
//  allocated_storage = "${var.storage}"
//  engine = "${var.engine}"
//  engine_version = "${lookup(var.engine_version, var.engine)}"
//  instance_class = "${var.instance_class}"
//  name = "${var.db_name}"
//  username = "${var.username}"
//  password = "${var.password}"
//  vpc_security_group_ids = ["${aws_security_group.default.id}"]
//  db_subnet_group_name = "${aws_db_subnet_group.default.id}"
//  backup_retention_period = "1"
//}
//
//resource "aws_db_instance" "default_replica1" {
//  identifier = "replica1"
//  replicate_source_db = "${aws_db_instance.default.identifier}"
//  availability_zone = "ap-northeast-1a"
//  allocated_storage = "${var.storage}"
//  engine = "${var.engine}"
//  engine_version = "${lookup(var.engine_version, var.engine)}"
//  instance_class = "${var.instance_class}"
//  name = "${var.db_name}"
//  username = "${var.username}"
//  password = "${var.password}"
//  vpc_security_group_ids = ["${aws_security_group.default.id}"]
//  db_subnet_group_name = "${aws_db_subnet_group.default.id}"