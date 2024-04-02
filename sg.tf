data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
  
}

resource "aws_security_group" "project_sg" {
  name        = "project_allow2"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id
  

  dynamic "ingress" {
    for_each = [22]
    iterator = port

    content {
      description = "TLS from VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "vova_sg"
  }
}
