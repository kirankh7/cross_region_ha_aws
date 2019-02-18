module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "flaskdb"

  engine            = "mysql"
  engine_version    = "5.7.19"
  instance_class    = "db.t2.micro"
  allocated_storage = 5

  name     = "${var.DB_NAME}"
  username = "${var.DB_USER}"
  password = "${var.DB_PASS}"
  port     = "3306"

  # Change after configuration ## Note
//  publicly_accessible = true

  iam_database_authentication_enabled = true

  vpc_security_group_ids = ["${aws_security_group.tier1.id}"]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
//  monitoring_interval = "30"
//  monitoring_role_name = "MyRDSMonitoringRole"
//  create_monitoring_role = false

  tags = {
    Owner       = "flask"
    Environment = "${var.ENV}"
  }

  # DB subnet group
  subnet_ids = "${var.PRIVATE_SUBNETS}"

  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = "5.7"

  # Snapshot name upon DB deletion
  final_snapshot_identifier = "demodb"

  # Database Deletion Protection
  deletion_protection = false

  parameters = [
    {
      name = "character_set_client"
      value = "utf8"
    },
    {
      name = "character_set_server"
      value = "utf8"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
}

resource "null_resource" "delay" {
  provisioner "local-exec" {
    command = "sleep 300"
  }
}