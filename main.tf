terraform {
  backend "remote" {
    organization = "marcelo-milera"

    workspaces {
      name = "terraform-training"
    }
  }

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

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/22"

  azs             = ["sa-east-1a", "sa-east-1b", "sa-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}