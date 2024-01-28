
variable "vpc_security_group_ids" {}



variable "private_subnet_id" {
  type = list(string)
}


resource "aws_instance" "private_ec2_instance" {
  count = length(var.private_subnet_id)
  ami             = "ami-0c7217cdde317cfec"  # Specify the desired AMI ID
  key_name        = "terra-key"
  instance_type   = "t2.micro"
  availability_zone = "us-east-1a"
  subnet_id       = element(var.private_subnet_id,count.index)  # Attach the instance to the public subnet
  vpc_security_group_ids  = [var.vpc_security_group_ids]

  tags = {
    Name = "private-ec2-instance-demo-${count.index + 1}"
  }
}

output "private_instance_id" {
  value = aws_instance.private_ec2_instance[*].id
}

resource "aws_eip" "elastic-ip" {
  
  domain = "vpc"
}

output "allocation_id" {
  value = aws_eip.elastic-ip.id
}