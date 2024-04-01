provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "example" {
  instance_type          = var.my_instance_type
  ami                    = var.my_ami
  key_name               = ec2_s_key
  #private_ip             = "172.31.40.104"
  vpc_security_group_ids = ["${aws_security_group.project_sg.id}"]

  tags = {
    Name = "vova_project"
  }
  user_data = "${file("run.sh")}"
}


