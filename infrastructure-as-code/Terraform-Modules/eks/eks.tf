# Create EKS cluster IAM role
resource "aws_iam_role" "eks" {
  name               = "${var.project_name}-${terraform.workspace}-${var.eks_name}-iam-role"
  assume_role_policy = <<POLICY
    {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}
resource "aws_iam_role_policy_attachment" "eks" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks.name
}

resource "aws_eks_cluster" "this" {
  name     = "${var.project_name}-${terraform.workspace}-${var.eks_name}-cluster"
  role_arn = aws_iam_role.eks.arn
  vpc_config {
    subnet_ids              = var.subnet_ids
    endpoint_private_access = false
    endpoint_public_access  = true
  }
  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true

  }

  depends_on = [aws_iam_role_policy_attachment.eks]

}
