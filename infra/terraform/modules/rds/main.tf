# # 1. Create the DB Subnet Group (Tells RDS which subnets to live in)
resource "aws_db_subnet_group" "main" {
  name       = "${var.environment}-rds-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name        = "${var.environment}-rds-subnet-group"
    Environment = var.environment
  }
}

# # 2. Provision the RDS Database Instance
resource "aws_db_instance" "main" {
  allocated_storage      = 20
  max_allocated_storage  = 50
  engine                 = "postgres"
  engine_version         = "15"
  instance_class         = "db.t4g.micro"
  
  db_name                = "phoenix_db"
  username               = "phoenix_user"
  password               = var.db_password
  
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.db_security_group_id]
  
  skip_final_snapshot    = true
  publicly_accessible    = true
  tags = {
    Name        = "${var.environment}-database"
    Environment = var.environment
  }
}
