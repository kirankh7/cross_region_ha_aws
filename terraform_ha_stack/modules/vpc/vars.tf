variable "ENV" {}
variable "AWS_REGION" {}

variable "VPC_CIDR" {}
variable "PRIVATE_SUBNET" {
  type = "list"
}
variable "PUBLIC_SUNET" {
  type = "list"
}