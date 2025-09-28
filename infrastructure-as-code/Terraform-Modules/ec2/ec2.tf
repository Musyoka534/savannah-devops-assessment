# Deploy EC2 instance with a static IP address
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key_pem" {
  content  = tls_private_key.ssh_key.private_key_pem
  filename = "${path.module}/id_rsa"
}

resource "aws_key_pair" "generated_key" {
  key_name   = "musyoka-ec2-key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

# Elastic IP
resource "aws_eip" "static_ip" {
  instance = aws_instance.ec2.id
}

resource "aws_instance" "ec2" {
  ami                         = var.image_id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.generated_key.key_name
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true

  root_block_device {
    volume_size = 50 
    volume_type = "gp3"
    encrypted   = true
    tags = merge(var.tags, {
      Name = "${var.project_name}-${terraform.workspace}-ec2-EBS-VOLUME"
    })
  }

  tags = merge(var.tags, {
    Name = "${var.project_name}-${terraform.workspace}-ec2"
  })
  depends_on = [ aws_key_pair.generated_key ]
}


