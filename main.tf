terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.94.1"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "myserver" {
  ami = "ami---"
  instance_type = "t2.micro"

  tags = {
    Name = "Smaple"
  }

  
}