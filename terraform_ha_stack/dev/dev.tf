module "main-vpc" {
  source = "../modules/vpc"
  ENV = "us-east-1"
  AWS_REGION = "${terraform.workspace}"
  VPC_CIDR = "172.0.0.0/16"
  PRIVATE_SUBNET = ["172.0.1.0/24", "172.0.2.0/24", "172.0.3.0/24"]
  PUBLIC_SUNET = ["172.0.101.0/24", "172.0.102.0/24", "172.0.103.0/24"]
}

//module "database" {
//  source = "../modules/mysql-db"
//  ENV = "prod"
//  VPC_ID = "${module.main-vpc.vpc_id}"
//  DB_NAME = "flaskdb"
//  DB_USER = "pipuser"
//  DB_PASS = "PiPU12323%%!123"
//  PRIVATE_SUBNETS = ["${module.main-vpc.private_subnets}"]
//  ALLOW_TIER2 = "${module.instances.tier2_sec_group}"
//}

module "alb" {
  source = "../modules/alb"
  ENV = "prod"
  VPC_ID = "${module.main-vpc.vpc_id}"
  PUBLIC_SUBNETS = ["${module.main-vpc.public_subnets}"]
  PRIVATE_SUBNETS = ["${module.main-vpc.private_subnets}"]
//  INSTANCE_ID = "${module.instances.instance_id}"
  LOG_BUCKET = "kiran-flask-app001"
  LOG_REGION_ID = "127311923021"  #us-east-1
}

module "instances" {
  source = "../modules/instances"
  ENV = "prod"
  INSTANCE_COUNT = 2
  VPC_ID = "${module.main-vpc.vpc_id}"
  PUBLIC_SUBNETS = ["${module.main-vpc.public_subnets}"]
  ALB_SEC_GROUP = "${module.alb.allow-elb-traffic}"
  AWS_REGION = "${terraform.workspace}"
  TR_GROUP_NAME = ["${module.alb.target_group_name}"]
//  DB_ENDPOINT = "${module.database.db_connection_enpoint}"
  DB_NAME = "${var.DB_NAME}"
  DB_USERNAME = "${var.DB_USER}"
  DB_PASSWORD = "${var.DB_PASS}"

}
//
//module "module_instances" {
//  source = "../modules/module_instance"
//  ENV = "prod"
//  INSTANCE_COUNT = 3
//  VPC_ID = "${module.main-vpc.vpc_id}"
//  PUBLIC_SUBNETS = ["${module.main-vpc.public_subnets}"]
//  ALB_SEC_GROUP = "${module.alb.allow-elb-traffic}"
//  AWS_REGION = "${var.AWS_REGION}"
//  TR_GROUP_NAME = ["${module.alb.target_group_name}"]
//  DB_ENDPOINT = "${module.database.db_connection_enpoint}"
//  DB_NAME = "${var.DB_NAME}"
//  DB_USERNAME = "${var.DB_USER}"
//  DB_PASSWORD = "${var.DB_PASS}"
//}

module "route53" {
  source = "../modules/route53"
  ENV = "prod"
  AWS_REGION = "${terraform.workspace}"
  ALB1 = "${module.alb.alb1_dns_name}"
  ALB_ZONE_ID ="${module.alb.alb_zone_id}"
  REGION_WAIT = 90
}
