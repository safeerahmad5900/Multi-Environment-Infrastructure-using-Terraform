
#  Define the provider
provider "aws" {
  region = "us-east-1"
}

# Accessing remote state from nonprod env
data "terraform_remote_state" "nonprod_remote_state" {
  backend ="s3" 
  config = {
    bucket = "nonprod-acs730-assigmnent1-safeer"    // Bucket where to SAVE Terraform State
    key    = "nonprod-01-Network/terraform.tfstate" // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                            // Region where bucket is created
  }
}


# Accessing remote state from prod env

data "terraform_remote_state" "prod_remote_state" {
  backend = "s3" 
  config = {
    bucket = "prod-acs730-assigmnent1-safeer"    // Bucket where to SAVE Terraform State
    key    = "prod-01-Network/terraform.tfstate" // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                         // Region where bucket is created
  }
}

# Creating VPC Conncection 

resource "aws_vpc_peering_connection" "VPC_Peering" {
  peer_vpc_id = data.terraform_remote_state.prod_remote_state.outputs.vpc_id   ## VPC ID of Prod Env
  vpc_id      = data.terraform_remote_state.nonprod_remote_state.outputs.vpc_id  ## VPC ID of Non Prod Env
  auto_accept = true
  
    tags = {
    Name= "VPC to VPC True Love Connection"
  }
}


resource "aws_vpc_peering_connection_options" "Peering_Connection" {
  vpc_peering_connection_id = aws_vpc_peering_connection.VPC_Peering.id


  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}
# Creating Route table for Peering connection 

#Acceptor Rout table 
resource "aws_route_table" "acceptor_route_table" {
    vpc_id  = data.terraform_remote_state.prod_remote_state.outputs.vpc_id   ## Prod 
    route {
      cidr_block        = "10.1.2.0/24"
      vpc_peering_connection_id     = aws_vpc_peering_connection.VPC_Peering.id
    }
    depends_on  = [aws_vpc_peering_connection.VPC_Peering]
    tags = {
        Name    = "Acceptor_Route_table"
    }
}

#Requestor Route table 
resource "aws_route_table" "requestor_route_table" {
    vpc_id  = data.terraform_remote_state.nonprod_remote_state.outputs.vpc_id  ## Non Prod
    route {
      cidr_block        = "0.0.0.0/0"
       gateway_id        = data.terraform_remote_state.nonprod_remote_state.outputs.aws_internet_gateway
    }
    route {  
      cidr_block        = data.terraform_remote_state.prod_remote_state.outputs.prod_VPC_Cidr   ##  PRod VPC CIDR Block 
      vpc_peering_connection_id     = aws_vpc_peering_connection.VPC_Peering.id
    }
    depends_on  = [aws_vpc_peering_connection.VPC_Peering]
    tags = {
        Name    = "Requestor_Route_table"
    }
}

# Associate subnets Association with Acceptor route table 
resource "aws_route_table_association" "acceptor_routes" {
  count          = length(data.terraform_remote_state.prod_remote_state.outputs.private_subnet_ids)
  route_table_id = aws_route_table.acceptor_route_table.id
  subnet_id      = data.terraform_remote_state.prod_remote_state.outputs.private_subnet_ids[count.index]  ### Production Privae subnet 
}

# Associate subnets Association with requestor Route table   
resource "aws_route_table_association" "requestor_routes" {
  route_table_id = aws_route_table.requestor_route_table.id  ## Non Prod Public Subnet 
  subnet_id      = data.terraform_remote_state.nonprod_remote_state.outputs.public_subnet_ids[1]   ## Non prord Public Subnet 
}


/* 
Main linking  Code 1 it is not working used from the Linked in learning


# Route table for nonprod VPC Peering_Connection

resource "aws_route" "nonprod_route_table_peering" {
  count                     = length(data.terraform_remote_state.nonprod_remote_state.outputs.public_cidr_blocks)
  route_table_id            = data.terraform_remote_state.nonprod_remote_state.outputs.public_route_table
  destination_cidr_block    = data.terraform_remote_state.prod_remote_state.outputs.private_ip[count.index]
  vpc_peering_connection_id = aws_vpc_peering_connection.VPC_Peering.id
}

# Route table for prod VPC Peering_Connection

resource "aws_route" "prod_route_table_peering" {
  count                     = length(data.terraform_remote_state.prod_remote_state.outputs.private_ip)
  route_table_id            = data.terraform_remote_state.prod_remote_state.outputs.private_route_table
  destination_cidr_block    = data.terraform_remote_state.nonprod_remote_state.outputs.public_cidr_blocks[count.index]
  vpc_peering_connection_id = aws_vpc_peering_connection.VPC_Peering.id
}

*/