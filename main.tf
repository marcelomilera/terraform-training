terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.5.0"
    }
  }
}

provider "aws" {
  profile                 = "marcelo-milera"
  region                  = "sa-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-013dd6e24f90aa93f"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["sg-402e5431"]
  subnet_id              = "subnet-2bbf2970"
}