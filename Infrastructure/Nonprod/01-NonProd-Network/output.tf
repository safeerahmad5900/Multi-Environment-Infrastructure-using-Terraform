# Output variables for Public Subnets
output "public_subnet_ids" {
  value = module.vpc-dev.public_subnet_ids
}
# Output variables for VPC 
output "vpc_id" {
  value = module.vpc-dev.vpc_id
}
# Output variables for Private VPC
output "private_subnet_ids" {
  value = module.vpc-dev.private_subnet_ids
}
# Output variables for Nat Gate Way
output "aws_nat_gateway" {
  value = module.vpc-dev.nat_gateway_id
}
# Output variables for Internet Gateway
output "aws_internet_gateway" {
  value = module.vpc-dev.aws_internet_gateway
}
 
# Output variables for Elastic IP

output "aws_eip" {
  value = module.vpc-dev.aws_eip
}

# Output variables for Private Route

output "private_route_table" {
  value = module.vpc-dev.private_route_table
}

# Output variables for Public Route Table

output "public_route_table" {
  value = module.vpc-dev.public_route_table
}

# Output variables for Public Cidr Block
output "public_cidr_blocks" {
  value = module.vpc-dev.public_cidr_blocks
}

# Output variables for Private CIDR block 
output "private_cidr_blocks" {
  value = module.vpc-dev.private_cidr_blocks
}