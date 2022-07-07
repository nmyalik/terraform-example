module "sg" {
  source  = "cloudposse/security-group/aws"
  version = "1.0.1"

  # Security Group names must be unique within a VPC.
  # This module follows Cloud Posse naming conventions and generates the name
  # based on the inputs to the null-label module, which means you cannot
  # reuse the label as-is for more than one security group in the VPC.
  #
  # Here we add an attribute to give the security group a unique name.
  attributes = ["primary"]

  # Allow unlimited egress
  allow_all_egress = true

  rules = [
    {
      key         = "HTTPS"
      type        = "ingress"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = [local.whole_internet_cidr]
      self        = false
      description = "Allow HTTPS from anywhere"
    },
    {
      key         = "HTTP"
      type        = "ingress"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = [local.whole_internet_cidr]
      self        = false
      description = "Allow HTTP from inside the security group"
    }
  ]

  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
}