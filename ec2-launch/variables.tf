variable "instance_name" {
  description = "Pass the instance name as per the requirement"
}

variable "security_group" {
  description = "what ports we want to allow via our created sg"
  default = "sg-e70b939b"
}

variable "instance_type" {
  description = "Pass the instance type for each instance as per the requirement"
}

variable "subnet_id" {
  description = "Specify which instance belongs to what subnet"
}

variable "key_name" {
   default = "terra-formation-1"
}

variable "public_key" { default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDmdZ8RSijpjMVJb0vPtoeKSvRvXlGkzQqam0oNfXxVjjzkdvr/2BCz8oyrHFW4YaioTXmJp9qfOLUacxnF2Xe4aM9Ibz7IagoGVfH8Q+DQsdncPw58bcWpGkGH+kvq0qjaPfT9NxjKwS3RwoUpmVj30I4XDt47KbqfZifq71NwLkbhTuMoCSPbU1+sDplGx/GjFWCDm/+K4koLsZHWHomr6294H1KnO6osjIUTqDX9skdw0cQEeTksR5mI1lOtWy1dUqN06/bWiBwLhSqOTegWG9FI7uZa/9JHLgY7WqQz7NKoGIABHq75rxBsFzKpOR5Xn3dvN2zuVGG4HHZTyDsN" }

variable "default_region" {}
variable "ami-id" {}
