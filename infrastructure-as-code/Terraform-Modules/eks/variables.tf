variable "eks_name" {
  description = "Name of the cluster"
  type        = string
}
variable "eks_version" {
  description = "Desired Kubernetes master version."
  type        = string
}
variable "subnet_ids" {
  description = "List of subnet IDs. Must be in at least two different availability zones."
  type        = list(string)
}
variable "node_iam_policies" {
  description = "List of IAM Policies to attach to EKS-managed nodes."
  type        = map(any)
  default = {
    1 = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    2 = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    3 = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    4 = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }
}
variable "enable_irsa" {
  description = "Determines whether to create an OpenID Connect Provider for EKS to enable IRSA"
  type        = bool
  default     = true
}
# Project name Variable
variable "project_name" {
  description = "The base name for resources"
  type        = string
}
variable "on-demand-node-groups" {
  description = "EKS node groups"
  type        = map(any)
}
variable "spot-instance-node-groups" {
  description = "EKS node groups"
  type        = map(any)
}
variable "tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
}
variable "addons" {
  type = list(object({
    name    = string
    version = string
  }))
}
