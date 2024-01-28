#create variable for cidr
variable "vpc_cidr" {
  default = "10.0.0.0/16"
  }

# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "vpc_higer_level"
  }
}

output "vpc_id" {
  value = aws_vpc.my_vpc.id
  }
