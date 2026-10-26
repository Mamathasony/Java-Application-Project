# 1. Automatically find the latest Ubuntu 24.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# 2. Create the DevSecOps Agent EC2 instance
resource "aws_instance" "agent" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.large"
  subnet_id                   = aws_subnet.public[0].id
  vpc_security_group_ids      = [aws_security_group.agent_sg.id]
  associate_public_ip_address = true

  # Run the installation script automatically
  user_data = file("${path.module}/user_data.sh")

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  tags = {
    Name    = "${var.project_name}-agent"
    Project = var.project_name
    Role    = "DevSecOps-Agent"
  }
}

# 3. Output the Agent details
output "agent_public_ip" {
  description = "Public IP of the DevOps Agent"
  value       = aws_instance.agent.public_ip
}

output "agent_public_dns" {
  description = "Public DNS of the DevOps Agent"
  value       = aws_instance.agent.public_dns
}

output "agent_instance_id" {
  description = "EC2 instance ID of the DevOps Agent"
  value       = aws_instance.agent.id
}