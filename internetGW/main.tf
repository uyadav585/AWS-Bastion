variable "vpc_id" {}
variable "public_subnet_id" {}



# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id


  tags = {
    Name = "igw-1"
  }
}


output "igw_id" {
  value = aws_internet_gateway.igw.id
}
