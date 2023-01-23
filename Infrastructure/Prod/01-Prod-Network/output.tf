#Output for Private Subnets
output "private_subnet_ids" {
  value = aws_subnet.private_subnet[*].id
}

#Output for Private IP
output "private_ip" {

  value = var.private_cidr_blocks

}

#Output for VPC ID
output "vpc_id" {
  value = aws_vpc.vpc_prod.id

}
#Output for  CIDR block 
output "prod_VPC_Cidr" {
  value = var.vpc_cidr
}
