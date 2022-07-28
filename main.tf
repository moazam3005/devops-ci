provider "aws" {
  region  = "us-east-2"
  access_key = "AKIATSR74TEBYD5OX6HS"
  secret_key = "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"

}

resource "aws_security_group" "SecurityGroup" {
  name = "Security Group"

  ingress {
    from_port   = 3000
    to_port     = 3000
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
  
  user_data = <<-EOL
  #!/bin/bash -xe
  
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
  . ~/.nvm/nvm.sh
  nvm install node
  https://github.com/moazam3005/devops-ci.git  
  cd src
  npm install
  node index.js
  
  EOL

  tags = {
    Name = "terraform"
  }
 # user_data = file("install.sh")

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


