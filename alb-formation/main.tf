resource "aws_default_subnet" "us-east-1a" { 
  availability_zone = "${var.faz}"
 }
resource "aws_default_subnet" "us-east-1b" {
  availability_zone = "${var.saz}" 
 }


resource "aws_lb" "aks-terra-alb" {
  name = "${var.lb_name}"
  subnets = [
    "${aws_default_subnet.us-east-1a.id}",
    "${aws_default_subnet.us-east-1b.id}",
  ]
  internal = "${var.internalalb}"
  
  enable_deletion_protection = "${var.delprotection}"
}


resource "aws_lb_listener" "fe" {
  load_balancer_arn = "${aws_lb.aks-terra-alb.arn}"
  port              = "${var.listener_port}"
  protocol          = "${var.listener_protocol}"

  default_action {
    target_group_arn = "${aws_lb_target_group.aks-tg.arn}"
    type             = "forward"
  }
}

resource "aws_vpc" "main" {
  cidr_block = "${var.cidr_block}"
}

resource "aws_lb_listener_rule" "listener-rule" {
  depends_on = ["aws_lb_target_group.aks-tg"]
  listener_arn = "${aws_lb_listener.fe.arn}"
  priority = 100
  action { 
   type = "forward"

  target_group_arn = "${aws_lb_target_group.aks-tg.id}"
  }

  condition {
   field = "path-pattern"
  values = ["/listener-rule/*"]
  }
}

resource "aws_lb_target_group" "aks-tg" {
  name     = "${var.targetgroup_name}"
  port     = "${var.targetgroup_port}"
  protocol = "${var.targetgroup_protocol}"
  vpc_id   = "${var.vpc_id}"

 health_check {
  healthy_threshold = "${var.healthy_threshold}"
  unhealthy_threshold = "${var.unhealthy_threshold}"
  timeout = "${var.timeout}"
 interval = "${var.interval}"
 path = "/"
 }
}


#This should have attached the newly launched instances to the target group targets. We will just have to add the 2 ec2 instances to newly created target group and hit the ALB endpoint to get the nginx page 
 
#resource "aws_lb_target_group_attachment" "tg-attachment" {
#  target_group_arn = "${aws_lb_target_group.aks-tg.arn}"
#  target_id        = "${aws_instance.p1.id}"
#  port             = 80
#}
