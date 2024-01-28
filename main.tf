terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


# All the modules are being called

module "vpc" {
  source = "./vpc"
}

module "subnets" {
  source = "./subnets"
  vpc_id = module.vpc.vpc_id
}

module "igw1" {
  source = "./internetGW"
  vpc_id = module.vpc.vpc_id
  public_subnet_id = module.subnets.public_subnet_id
}

module "ec2" {
  source = "./ec2_instance"
  public_subnet_id = module.subnets.public_subnet_id
  vpc_security_group_ids = module.security.vpc_security_group_id
}

module "security" {
  source = "./security_group"
  vpc_id = module.vpc.vpc_id
}

module "route-table" {
  source = "./route_table"
  
  vpc_id = module.vpc.vpc_id
  igw_id = module.igw1.igw_id
  nat_id = module.nat-gateway.nat_id
  public_subnet_id = module.subnets.public_subnet_id
  private_subnet_id = module.subnets.private_subnet_id
}

module "nat-gateway" {
  source = "./NAT"
  allocation_id = module.private-ec2.allocation_id
  public_subnet_id = module.subnets.public_subnet_id
}


module "private-ec2" {
  source = "./private_ec2_instance"
  private_subnet_id = module.subnets.private_subnet_id
  vpc_security_group_ids = module.security.vpc_security_group_id
}