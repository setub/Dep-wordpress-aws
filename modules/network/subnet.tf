# Providing a reference to our default subnets
resource "aws_default_subnet" "demo-vpc-subnet1" {
  availability_zone = "us-east-1a"
}

resource "aws_default_subnet" "demo-vpc-subnet2" {
  availability_zone = "us-east-1b"
}

resource "aws_default_subnet" "demo-vpc-subnet3" {
  availability_zone = "us-east-1c"
}


output "subnet1-id" {
  value = aws_default_subnet.demo-vpc-subnet1.id
}

output "subnet2-id" {
  value = aws_default_subnet.demo-vpc-subnet2.id
}

output "subnet3-id" {
  value = aws_default_subnet.demo-vpc-subnet3.id
}

output "subnet1-cidr" {
  value = aws_default_subnet.demo-vpc-subnet1.cidr_block
}

output "subnet2-cidr" {
  value = aws_default_subnet.demo-vpc-subnet2.cidr_block
}

output "subnet3-cidr" {
  value = aws_default_subnet.demo-vpc-subnet3.cidr_block
}