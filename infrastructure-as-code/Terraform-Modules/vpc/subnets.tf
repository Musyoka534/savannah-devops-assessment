resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.azs[count.index]
  tags = merge(var.tags, {
    Name = "${var.project_name}-${terraform.workspace}-private-subnet-${var.azs[count.index]}" }, var.private_subnet_tags
  )
}


resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true
  tags = merge(var.tags,
    { Name = "${var.project_name}-${terraform.workspace}-public-subnet-${var.azs[count.index]}" }, var.public_subnet_tags
  )
}
resource "aws_subnet" "db-subnet" {
  count             = length(var.db_subnets)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.db_subnets[count.index]
  availability_zone = var.azs[count.index]
  tags = merge(var.tags,
    { Name = "${var.project_name}-${terraform.workspace}-database-subnet-${var.azs[count.index]}" }, var.db_subnets_tags
  )
}

