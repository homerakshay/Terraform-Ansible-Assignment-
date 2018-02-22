module "instance-1" {
   source = "../ec2-launch"
   instance_name = "plivo1"
   instance_type = "t2.micro"
   subnet_id = "subnet-de4114f3"
   default_region = "us-east-1"
   ami-id = "ami-97785bed"
}


module "instance-2" {
   source = "../ec2-launch"
   instance_name = "plivo2"
   instance_type = "t2.small"
   subnet_id = "subnet-af2f15e6"
   default_region = "us-east-1"
   ami-id = "ami-97785bed"
}

module "alb-mod" {
  source = "../alb-formation"
  lb_name = "aks-terra-alb-formation"
  subnet_id = "subnet-de4114f3"
  faz = "us-east-1a"
  saz = "us-east-1b"
  internalalb = "false"
  delprotection = "false"
  listener_port = 80
  listener_protocol = "HTTP"
  targetgroup_name = "aks-terra-target-group"
  targetgroup_port = 80
  targetgroup_protocol = "HTTP"
  healthy_threshold = 3
  unhealthy_threshold = 10
  timeout = 5
  interval = 10
}
