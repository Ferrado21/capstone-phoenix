output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The ID of the main VPC"
}

output "public_subnet_ids" {
  value       = [aws_subnet.public_1.id, aws_subnet.public_2.id]
  description = "The IDs of the public subnets"
}
output "db_security_group_id" {
  value       = aws_security_group.db_sg.id
  description = "The ID of the database security group"
}
output "public_subnet_id" {
  value       = aws_subnet.public_1.id
  description = "The ID of the primary public subnet"
}

output "compute_security_group_id" {
  value       = aws_security_group.compute_sg.id
  description = "The ID of the compute security group"
}
