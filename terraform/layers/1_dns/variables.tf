locals {
  aws_region = "eu-central-1"
}

variable "env" {
  default = "development"
}

variable "root_zone" {
  default = "dev.com"
}