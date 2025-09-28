# Terraform Infrastructure

This folder contains Terraform modules for deploying AWS VPC,EC2,EKS and related resources. Each module is designed to be reusable and can be combined to build a scalable and secure infrastructure.

## Project Structure

```bash
.
├── backend.tf
├── main.tf
├── outputs.tf
├── providers.tf
├── README.md
├── Terraform-Modules
│   ├── aws-loadbalancer-controller # Provisions aws loadd balancer controller to be used by ingress when exposing services
│   │   ├── data.tf
│   │   ├── files
│   │   │   └── iam-policy.json
│   │   ├── main.tf
│   │   ├── README.md
│   │   ├── variables.tf
│   │   └── versions.tf
│   ├── ec2.           # Provisions an EC2 instane with a static public IP
│   │   ├── ec2.tf
│   │   ├── outputs.tf
│   │   ├── securitygroups.tf
│   │   └── variables.tf
│   ├── eks             # Provisions an EKS cluster with both on-demand managed nodes and spot instances
│   │   ├── addons.tf
│   │   ├── eks.tf
│   │   ├── irsa.tf
│   │   ├── node-iam.tf
│   │   ├── nodes.tf
│   │   ├── outputs.tf
│   │   ├── README.md
│   │   ├── variables.tf
│   │   └── versions.tf
│   └── vpc            # Provisions VPC with public/private subnets and networking resources
│       ├── igw.tf
│       ├── nat.tf
│       ├── outputs.tf
│       ├── README.md
│       ├── routes.tf
│       ├── subnets.tf
│       ├── variables.tf
│       ├── versions.tf
│       └── vpc.tf
├── terraform.tfvars
├── variables.tf
└── versions.tf           
```
## Prerequisites

Before using these Terraform modules to deploy the EC2 and VPC resources, ensure you have the following installed and configured:

1. **Terraform**: Version 1.x or above.
   - [Download Terraform](https://www.terraform.io/downloads.html)
   - Installation guide for [Linux](https://learn.hashicorp.com/tutorials/terraform/install-cli), [MacOS](https://learn.hashicorp.com/tutorials/terraform/install-cli#install-terraform-on-macos), [Windows](https://learn.hashicorp.com/tutorials/terraform/install-cli#install-terraform-on-windows)

2. **AWS CLI**: Version 2.x or above for managing AWS services.
   - [Download AWS CLI](https://aws.amazon.com/cli/)
   - Installation guide for [Linux](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html), [MacOS](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-mac.html), [Windows](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-windows.html)

3. **AWS IAM Credentials**:
   - Ensure you have AWS IAM credentials with sufficient permissions to create the required resources.
   - Example permissions required:
     - `AmazonEC2FullAccess`
     - `AmazonVPCFullAccess`
   - Configure using:
     ```bash
     aws configure
     ```

4. **Backend for Terraform State**:
   - To maintain state consistency, store the Terraform state in an S3 bucket with DynamoDB for state locking:
     ```hcl
     backend "s3" {
       bucket         = "musyokatfstate"
       key            = "tfstate"
       region         = "us-east-1"
       dynamodb_table = "terraform-lock-table"
     }
     ```

6. **kubectl** (if using EKS):
   - Required for managing Kubernetes clusters.
   - [Download kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

### Optional

- **Docker**: If your project involves containerized applications, install Docker:
  - [Download Docker](https://docs.docker.com/get-docker/)
  - Verify installation:
    ```bash
    docker --version
    ```

Once these prerequisites are installed and configured, you're ready to deploy the resources.

## Usage:EC2 Instance

To deploy an EC2 instance, add the following module configuration in your Terraform file:
### Variables are defined in the terraform.tfvars file
```hcl
module "ec2" {
  source = "./modules/ec2"
  vpc_id = module.vpc.vpc_id
  image_id = var.image_id
  key_name = var.key_name
  subnet_id = module.vpc.public_subnet_ids[0]
  instance_type = var.instance_type
  project_name = var.project_name
  tags = var.tags
  depends_on = [ module.vpc ] 
}
```

## Expected Outcome
Once Terraform completes deployment, you can verify that all the resources have been created from aws management console(VPC,public and private subnets,security groups,NAT gateway,internet gateway and EC2 instance) ,Alternatively you can you use ``` terraform state list ``` and ``` terraform state show ``` commands to view created resources



