variable "image_id" {
  description = "AMI Image for the EC2"
  type = string
  
}
variable "instance_type" {
  type = string

}
variable "vpc_id" {
  type = string
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
variable "subnet_id" {
  description = "subnet ID"
  type        = string
}