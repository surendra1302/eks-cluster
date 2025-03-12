terraform {
  required_version = ">= 1.3.0"
  backend "s3" {
    bucket         = "my-cluster-bucket-007"
    key            = "eks/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source  = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

module "eks" {
  source         = "./modules/eks"
  cluster_name   = var.cluster_name
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.public_subnets
}

module "nodegroup" {
  source         = "./modules/nodegroup"
  cluster_name   = module.eks.cluster_name
  node_role_arn  = module.eks.node_role_arn
  subnet_ids     = module.vpc.public_subnets
}
