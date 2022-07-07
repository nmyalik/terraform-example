locals {
  aws_region          = "eu-central-1"
  whole_internet_cidr = "0.0.0.0/0"
}

variable "env" {
  default = "development"
}
