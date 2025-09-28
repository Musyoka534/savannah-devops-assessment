variable "vpc_cidr_block" {
  description = "Classless InterDomain Routing"
  type        = string
}
variable "azs" {

  description = "Availability Zones  for Subnets"
  type        = list(string)

}
variable "private_subnets" {
  description = "CIDR ranges for private subnets"
  type        = list(string)

}
variable "public_subnets" {
  description = "CIDR ranges for public subnets"
  type        = list(string)
}
variable "private_subnet_tags" {
  description = "Private subnet tags"
  type        = map(any)

}
variable "public_subnet_tags" {
  description = "public subnet tags"
  type        = map(any)

}
variable "db_subnets" {
  description = "CIDR ranges for private DB subnets"
  type        = list(string)
}
variable "db_subnets_tags" {
  description = "db subnets tags"
  type        = map(any)
}
# Project name Variable
variable "project_name" {
  description = "The base name for resources"
  type        = string
}
variable "tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
}
