# module to deploy basic networing 
module "vpc-dev" {
  source = "/home/ec2-user/environment/Assignment1-Safeer-120477203/Modules/aws_network"
  #source              = "git@github.com:safeerahmad5900/networking.git"
  env                 = var.env
  vpc_cidr            = var.vpc_cidr
  private_cidr_blocks = var.private_subnet_cidrs
  public_cidr_blocks  = var.public_subnet_cidrs
  prefix              = var.prefix
  default_tags        = var.default_tags




}