terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.5.0"
    }
  }
}

provider "aws" {
  profile = "marcelo-milera"
  region  = "sa-east-1"
}

resource "aws_instance" "example" {
  ami                    = var.host["ami"]
  instance_type          = var.host["instance_type"]
  vpc_security_group_ids = var.security_groups["vpc_security_group_ids"]
  subnet_id              = var.host["subnet_id"]
}

output "host_public_dns" {
  value = aws_instance.example.public_dns
}

output "host_private_ip" {
  value = aws_instance.example.public_ip
}
