module "vpc" {
  source              = "./Terraform-Modules/vpc"
  db_subnets_tags     = var.db_subnets_tags
  public_subnet_tags  = var.public_subnet_tags
  private_subnet_tags = var.private_subnet_tags
  vpc_cidr_block      = var.vpc_cidr_block
  public_subnets      = var.public_subnets
  private_subnets     = var.private_subnets
  db_subnets          = var.db_subnets
  project_name        = var.project_name
  azs                 = var.azs
  tags                = var.tags
}
module "ec2" {
  source = "./Terraform-Modules/ec2"
  vpc_id = module.vpc.vpc_id
  image_id = var.image_id
  subnet_id = module.vpc.public_subnet_ids[0]
  instance_type = var.instance_type
  project_name = var.project_name
  tags = var.tags
  depends_on = [ module.vpc ]
}
module "eks" {
  source       = "./Terraform-Modules/eks"
  eks_name     = var.eks_name
  eks_version  = var.eks_version
  subnet_ids   = module.vpc.private_subnet_ids
  project_name = var.project_name
  on-demand-node-groups = var.on-demand-node-groups
  spot-instance-node-groups = var.spot-instance-node-groups
  tags         = var.tags
  addons = var.addons
  depends_on   = [module.vpc]
}
module "aws-loadbalancer-controller" {
  source = "./Terraform-Modules/aws-loadbalancer-controller"
  #cluster_name            = module.eks.eks_name
  oidc_provider_url = module.eks.oidc_provider_url
  vpc_id            = module.vpc.vpc_id
  eks_name          = module.eks.eks_name
  depends_on        = [module.vpc, module.eks]
}