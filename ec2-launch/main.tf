#Configure the AWS provider
provider "aws" {
        region = "${var.default_region}"
}

data "aws_security_group" "sec_group" {
 id = "${var.security_group}"
}


#create an ec2 instance
resource "aws_instance" "launchpad" {
        ami = "${var.ami-id}"
        instance_type = "${var.instance_type}"
        subnet_id = "${var.subnet_id}"
        key_name = "${var.key_name}"

 provisioner "local-exec" {
        command = "sleep 30 && echo ${aws_instance.launchpad.public_ip} >> /etc/ansible/hosts"
  }
   provisioner "local-exec" {
        command = "ansible-playbook /home/ec2-user/ansible/install_nginx_on_tagged_nodes.yml -u ec2-user --private-key=/home/ec2-user/terra-formation-1.pem"
}
   provisioner "local-exec" {
        command = "> /etc/ansible/hosts"
}
      security_groups = [ "${data.aws_security_group.sec_group.name}" ]

#Lets tag our ec2 instance
 tags {
        Component = "nginx"
        Name = "${var.instance_name}"
  }
}

output "get_id" {
  value = "${aws_instance.launchpad.id}"
}

 resource "aws_key_pair" "master-deployer" {
   key_name   = "${var.key_name}"
   public_key = "${var.public_key}"
}

resource "null_resource" "test" {}
