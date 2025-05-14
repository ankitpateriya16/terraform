variable "ami" {
  default = "ami-084568db4383264d4"
 type = string
}
variable "instance_type" {
 default = "t2.micro"
 type = string
}
variable "instance_name" {
 default = ["jenkins-server", "ansible_server" , "Docker-host"]
}

#ami-084568db4383264d4 us-east-1
#ami-058a8a5ab36292159 us-east-2
