resource "aws_instance" "app_server" {
  ami                    = "ami-0705384c0b33c194c" # Ubuntu 24.04 LTS (eu-north-1)
  instance_type          = "t3.micro"
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.compute_security_group_id]
  key_name               = var.key_name

  tags = {
    Name        = "${var.environment}-app-server"
    Environment = var.environment
  }
}
