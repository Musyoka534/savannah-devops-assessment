# Project Name tfvar
project_name = "devsecops"
# VPC module tfvars
vpc_cidr_block  = "10.245.0.0/16"
azs             = ["us-east-1a", "us-east-1b"]
private_subnets = ["10.245.1.0/24", "10.245.2.0/24"]
public_subnets  = ["10.245.3.0/24", "10.245.4.0/24"]
db_subnets      = ["10.245.5.0/24", "10.245.6.0/24"]
private_subnet_tags = {
  "kubernetes.io/role/internal-elb"                 = 1
  "kubernetes.io/cluster/devsecops-uat-eks-cluster" = "shared"
}
public_subnet_tags = {
  "kubernetes.io/role/elb"                          = 1
  "kubernetes.io/cluster/devsecops-uat-eks-cluster" = "shared"
}
db_subnets_tags = {
  "kubernetes.io/role/internal-elb"                 = 1
  "kubernetes.io/cluster/devsecops-uat-eks-cluster" = "shared"
}
tags = {
  "Project"     = "eks-workshop"
  "Owner"       = "Musyoka"
  "Environment" = "UAT"
}


#EKS Module tfvars

eks_name    = "eks"
eks_version = "1.31"
node_iam_policies = {
  1 = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  2 = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  3 = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  4 = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
on-demand-node-groups = {
  devsecops = {
    capacity_type  = "ON_DEMAND"
    instance_types = ["t2.medium"]
    scaling_config = {
      desired_size = 2
      max_size     = 5
      min_size     = 2
    }
  }
}
spot-instance-node-groups = {
  spot-nodes = {
    capacity_type  = "SPOT"
    instance_types = ["t2.medium","t3a.medium"]
    scaling_config = {
      desired_size = 1
      max_size     = 10
      min_size     = 1
    }
  }
}
addons = [
  {
    name    = "vpc-cni",
    version = "v1.20.0-eksbuild.1"
  },
  {
    name    = "coredns"
    version = "v1.12.2-eksbuild.4"
  },
  {
    name    = "kube-proxy"
    version = "v1.33.0-eksbuild.2"
  },
  # Add more addons as needed
]
enable_irsa = true

# EC2 Module tfvars
image_id      = "ami-0360c520857e3138f"
instance_type = "t2.micro"
