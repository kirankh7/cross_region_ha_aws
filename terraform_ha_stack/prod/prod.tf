module "main-vpc" {
  source = "../modules/vpc"
  ENV = "prod"
  AWS_REGION = "${var.AWS_REGION}"
}

module "database" {
  source = "../modules/mysql-db"
  ENV = "prod"
  VPC_ID = "${module.main-vpc.vpc_id}"
  DB_NAME = "flaskdb"
  DB_USER = "pipuser"
  DB_PASS = "PiPU12323%%!123"
  PRIVATE_SUBNETS = ["${module.main-vpc.private_subnets}"]
  ALLOW_TIER2 = "${module.instances.tier2_sec_group}"
}

module "alb" {
  source = "../modules/alb"
  ENV = "prod"
  VPC_ID = "${module.main-vpc.vpc_id}"
  PUBLIC_SUBNETS = ["${module.main-vpc.public_subnets}"]
  PRIVATE_SUBNETS = ["${module.main-vpc.private_subnets}"]
//  INSTANCE_ID = "${module.instances.instance_id}"
  LOG_BUCKET = "kiran-flask-app001"

}

module "instances" {
  source = "../modules/instances"
  ENV = "prod"
  VPC_ID = "${module.main-vpc.vpc_id}"
  PUBLIC_SUBNETS = ["${module.main-vpc.public_subnets}"]
  ALB_SEC_GROUP = "${module.alb.allow-elb-traffic}"
  AWS_REGION = "${var.AWS_REGION}"
  TR_GROUP_NAME = ["${module.alb.target_group_name}"]
  DATABASE_ENDPOINT = "${module.database.db_connection_enpoint}"
}
