output "vpc_id" {
  value = aws_vpc.this.id

}
output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}
output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}
output "db_subnets_ids" {
  value = aws_subnet.db-subnet[*].id

}