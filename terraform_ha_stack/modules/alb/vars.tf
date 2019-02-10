variable "VPC_ID" {}

variable "PUBLIC_SUBNETS" {
  type = "list"
}
variable "PRIVATE_SUBNETS" {
  type = "list"
}

variable "ENV" {}

variable "LOG_BUCKET" {}

//variable "INSTANCE_ID" {}


variable "TARGET_GROUP_NAME" {
  default = "flask-app-tg"
}