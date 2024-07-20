output "vpc_id" {
  value = aws_vpc.main.id
}

output "public1_id" {
  value = aws_subnet.publicsubnet1.id
}

output "public2_id" {
  value = aws_subnet.publicsubnet2.id
}