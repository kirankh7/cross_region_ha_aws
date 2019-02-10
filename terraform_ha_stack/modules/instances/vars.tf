variable "ENV" {}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}
variable "AWS_REGION" {}
variable "AMIS" {
  type = "map"
  default = {
    us-east-1 = "ami-035be7bafff33b6b6"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-0fad7378adf284ce0"
  }
}

variable "PUBLIC_SUBNETS" {
  type = "list"
}

variable "VPC_ID" {}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "ALB_SEC_GROUP" {}

variable "TR_GROUP_NAME" {
  type = "list"
}