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

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/22"

  azs             = ["sa-east-1a", "sa-east-1b", "sa-east-1c"]
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "allow_tcp" {
  name        = "allow_tcp"
  description = "Allow HTTP and HTTPS inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPs"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tcp"
  }
}

resource "aws_instance" "example" {
  ami                    = var.host["ami"]
  instance_type          = var.host["instance_type"]
  vpc_security_group_ids = [module.vpc.default_security_group_id,
                            aws_security_group.allow_ssh.id,
                            aws_security_group.allow_tcp.id]
  subnet_id              = module.vpc.public_subnets[0]
}