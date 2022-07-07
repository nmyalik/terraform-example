locals {
  aws_region          = "eu-central-1"
  availability_zones  = slice(data.aws_availability_zones.available.names, 0, var.az_number)
}

variable "env" {
  default = "development"
}

variable "default_cidr_block" {
  default = "10.0.0.0/16"
}

variable "az_number" {
  default = 2
}
