resource "aws_default_vpc" "demo-vpc" {
}

output "id" {
  value = aws_default_vpc.demo-vpc.id
}
