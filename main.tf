provider "aws" {
  region  = us-east-1
  access_key = AKIA24SYZGC63UC5LOUK
  secret_key = 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

}

resource "aws_security_group" "SecurityGroup" {
  name = "Security Group"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "EC2Instance" {
  instance_type          = "t2.medium"
  ami                    = data.aws_ami.ubuntu.id
  vpc_security_group_ids = [aws_security_group.SecurityGroup.id]
  key_name               = "node"

  tags = {
    Name = "terraform"
  }
  user_data = file("install.sh")

}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-18.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}


