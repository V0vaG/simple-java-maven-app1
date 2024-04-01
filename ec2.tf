provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "example" {
  ami = "ami-0b5c5343f7e9de232"  
  instance_type = "t3.micro"
  vpc_security_group_ids = ["${aws_security_group.vova_sg.id}"]

  tags = {
    Name = var.ec2_name
  }
  user_data = "${file("run.sh")}"
}


