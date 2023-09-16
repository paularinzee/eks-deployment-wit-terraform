output "VPC_ID" {
  value = aws_vpc.vpc.id
}

output "PUBLIC_SUB1_ID" {
  value = aws_subnet.public_sub1.id
}
output "PUBLIC_SUB2_ID" {
  value = aws_subnet.public_sub2.id
}
output "PRIVATE_SUB1_ID" {
  value = aws_subnet.private_sub1.id
}

output "PRIVATE_SUB2_ID" {
  value = aws_subnet.private_sub2.id
}
output "IGW_ID" {
    value = aws_internet_gateway.igw
}

output "REGION" {
  value = var.REGION
}