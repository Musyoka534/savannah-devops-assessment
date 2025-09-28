output "vpc_id" {
  value = module.vpc.vpc_id

}
output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids

}
output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids

}
output "db_subnets_ids" {
  value = module.vpc.db_subnets_ids
}




