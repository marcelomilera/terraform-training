variable "host" {
  type = map

  default = {
    "ami"                    = "ami-013dd6e24f90aa93f"
    "instance_type"          = "t2.micro"
    "subnet_id"              = "subnet-2bbf2970"
  }
}

variable "security_groups" {
    type = map

    default = {
        "vpc_security_group_ids" = ["sg-402e5431"]
    }
}
