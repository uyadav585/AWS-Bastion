
variable "vpc_security_group_ids" {}


variable "public_subnet_id" {
  type = list(string)
}


# Define an EC2 instance resource
resource "aws_instance" "public_ec2_instance" {
  count = length(var.public_subnet_id)
  ami             = "ami-0c7217cdde317cfec"  # Specify the desired AMI ID
  key_name        = "terra-key"
  instance_type   = "t2.micro"
  availability_zone = "us-east-1a"
  subnet_id       = element(var.public_subnet_id,count.index)  # Attach the instance to the public subnet
  vpc_security_group_ids  = [var.vpc_security_group_ids]

  tags = {
    Name = "public-ec2-instance-demo-${count.index + 1}"
  }
}

output "public_instance_id" {
  value = aws_instance.public_ec2_instance[*].id
}
