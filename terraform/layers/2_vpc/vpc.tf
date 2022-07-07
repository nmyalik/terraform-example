module "vpc" {
  source  = "cloudposse/vpc/aws"
  version = "1.1.0"

  stage = var.env
  name  = "test-vpc"

  ipv4_primary_cidr_block = var.default_cidr_block

  tags = {
    "Environment" = var.env
  }
}

module "subnets" {
  source  = "cloudposse/dynamic-subnets/aws"
  version = "2.0.2"

  stage                                 = var.env
  vpc_id                                = module.vpc.vpc_id
  igw_id                                = [module.vpc.igw_id]
  ipv4_cidr_block                       = [var.default_cidr_block]
  availability_zones                    = local.availability_zones
  public_route_table_per_subnet_enabled = true
  nat_gateway_enabled                   = false

  tags = {
    "Environment" = var.env
  }
}
