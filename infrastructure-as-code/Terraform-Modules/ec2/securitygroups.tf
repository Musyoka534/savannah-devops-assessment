# Define a security group for the EC2 host
resource "aws_security_group" "ec2" {
  vpc_id      = var.vpc_id
  description = "EC2 Security Group"
  # Allow SSH from a restricted IP range
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Restrict this to your IP or range for security
    description = "Allow ssh Access from CAREPAY NETWORK"
  }
  # Allow HTTP from the internet
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
    description = "Allow HTTP access from the internet"
  }
  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${terraform.workspace}-EC2-sg"
  }
}

