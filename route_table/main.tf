variable "vpc_id" {}
variable "igw_id" {}
variable "nat_id" {}
variable "public_subnet_id"{}
variable "private_subnet_id" {}





# Create a route table

# public route
resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = "public-route-table"
  }
}




# private route
resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.nat_id
  }

  tags = {
    Name = "private-route-table"
  }
}


resource "aws_route_table_association" "public_Association_table" {
  count = length(var.public_subnet_id)
  subnet_id = var.public_subnet_id[count.index]
  route_table_id = aws_route_table.public_route_table.id
}


resource "aws_route_table_association" "private_Association_table" {
  count = length(var.private_subnet_id)
  subnet_id = var.private_subnet_id[count.index]
  route_table_id = aws_route_table.private_route_table.id
}