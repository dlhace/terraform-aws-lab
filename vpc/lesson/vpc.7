terraform {
  backend "local" {}
}

provider "aws" {
  region = "${var.region}"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "${var.vpc_name}"
  cidr   = "${var.vpc_cidr}"
  azs = ["${var.region}a", "${var.region}b"]
  private_subnets = "${var.vpc_private_subnets}"
  public_subnets  = "${var.vpc_public_subnets}"
  tags = "${var.tags}"
}

data "aws_availability_zones" "az" {
  state = "available"
}
