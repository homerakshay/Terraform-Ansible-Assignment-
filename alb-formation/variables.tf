variable "lb_name" {
  type    = "string"
  default = ""
}

variable "subnet_id" {
 description = "subnet id's which should be attached to the alb"
}

variable "cidr_block" {
 default = "172.31.0.0/16"
}

variable "vpc_id" {
 default = "vpc-1ae9777c"
}

variable "faz" {
 description = "sets the 1st availability zone"
}

variable "saz" {
 description = "sets the 2nd availaibility zone"
}


variable "delprotection" {}
variable "healthy_threshold" {}
variable "listener_port" {}
variable "unhealthy_threshold" {}
variable "targetgroup_port" {}
variable "interval" {}
variable "targetgroup_protocol" {}
variable "listener_protocol" {}
variable "targetgroup_name" {}
variable "internalalb" {}
variable "timeout" {}
