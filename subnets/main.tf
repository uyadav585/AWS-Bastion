



variable "no_of_public_subnets" {
  type = number
  default = 1
}

variable "no_of_private_subnets" {
  type = number
  default = 1
}

# vpc id
variable "vpc_id" {}



# Create public subnet
resource "aws_subnet" "public_subnet" {
  count = var.no_of_public_subnets
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.${count.index + 10}.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet[*].id
}


# Create private subnet
resource "aws_subnet" "private_subnet" {
  count = var.no_of_private_subnets
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.${count.index + 1}.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet[*].id
}