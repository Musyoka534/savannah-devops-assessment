
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "eks_name" {
  description = "Name of the cluster"
  type        = string
}
variable "oidc_provider_url" {
  description = "The URL of the OIDC provider"
  type        = string
}
