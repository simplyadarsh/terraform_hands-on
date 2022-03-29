provider "aws" {
  profile = "Adarsh"
  region  = "us-east-1"
}

resource "aws_instance" "terra-ec2" {
  ami= "ami-0a01a5636f3c4f21c"
  instance_type = "t2.micro"
  tags = {
  Name = "Terra Instance "

 }

}



resource "aws_ebs_volume" "Vol-1" {
 availability_zone = aws_instance.terra-ec2.availability_zone
 size = 8
 tags = {
 Name = "New disk"

}
}



resource "aws_volume_attachment" "attachment" {
 device_name = "/dev/sdp"
 volume_id = aws_ebs_volume.Vol-1.id
 instance_id = aws_instance.terra-ec2.id

}

resource "aws_eip" "static-ip" {
  instance = aws_instance.terra-ec2.id
  vpc = true
}

resource "aws_security_group" "sg" {
name = "Custom sg"


ingress {
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["47.9.163.31/32"]

}


egress {
  from_port = 0
  protocol = "-1"
  to_port = 0
  cidr_blocks = ["0.0.0.0/0"]

}
}
