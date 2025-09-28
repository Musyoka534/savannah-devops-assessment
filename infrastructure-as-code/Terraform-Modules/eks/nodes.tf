
# on-demand managed nodes

resource "aws_eks_node_group" "on-demand-nodes" {
  for_each = var.on-demand-node-groups

  cluster_name    = aws_eks_cluster.this.name
  node_group_name = each.key
  node_role_arn   = aws_iam_role.nodes.arn

  subnet_ids = var.subnet_ids

  capacity_type  = each.value.capacity_type
  instance_types = each.value.instance_types

  scaling_config {
    desired_size = each.value.scaling_config.desired_size
    max_size     = each.value.scaling_config.max_size
    min_size     = each.value.scaling_config.min_size
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    role = each.key
    type = "ondemand"
  }
  tags = merge(var.tags, {
    Name = "devsecops-${each.key}-${terraform.workspace}-on-demand-nodes"

  })

  depends_on = [aws_iam_role_policy_attachment.nodes]
}

# spot instances nodes

resource "aws_eks_node_group" "spot-node" {
  for_each        = var.spot-instance-node-groups
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = each.key

  node_role_arn = aws_iam_role.nodes.arn

  scaling_config {
    desired_size = each.value.scaling_config.desired_size
    max_size     = each.value.scaling_config.max_size
    min_size     = each.value.scaling_config.min_size
  }

  subnet_ids = var.subnet_ids

  capacity_type  = each.value.capacity_type
  instance_types = each.value.instance_types

  update_config {
    max_unavailable = 1
  }
  tags = {
    "Name" = "${var.eks_name}-spot-nodes"
  }
  tags_all = {
    "kubernetes.io/cluster/${var.eks_name}" = "owned"
    "Name"                                  = "${var.eks_name}-spot-nodes"
  }
  labels = {
    type      = "spot"
    lifecycle = "spot"
  }
  disk_size = 50

  depends_on = [aws_eks_cluster.this]
}


