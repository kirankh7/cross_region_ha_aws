output "db_instance_address" {
  value = "${module.db.this_db_instance_address}"
}
output "db_connection_enpoint" {
  value = "${module.db.this_db_instance_endpoint}"
}
output "db_database_username" {
  value = "${module.db.this_db_instance_username}"
}

output "db_database_password" {
  value = "${module.db.this_db_instance_password}"
}