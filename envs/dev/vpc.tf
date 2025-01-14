# It's useful to manage public IP addresses outside of NAT/VPC module. 
# You can reuse them later or, for example, whitelist them with your customers for the webhook.
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.env}-main"
    Env  = var.env
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.17.0"

  name            = "${var.env}-main"
  cidr            = var.vpc_cidr
  azs             = [var.az1, var.az2]
  private_subnets = [cidrsubnet(var.vpc_cidr, 3, 0), cidrsubnet(var.vpc_cidr, 3, 1)]
  public_subnets  = [cidrsubnet(var.vpc_cidr, 3, 2), cidrsubnet(var.vpc_cidr, 3, 3)]

  enable_dns_hostnames    = true
  enable_dns_support      = true
  single_nat_gateway      = true
  enable_nat_gateway      = true
  reuse_nat_ips           = true
  one_nat_gateway_per_az  = false
  map_public_ip_on_launch = true
  external_nat_ip_ids     = [aws_eip.nat.id]

  tags = {
    Env = var.env
  }
}
