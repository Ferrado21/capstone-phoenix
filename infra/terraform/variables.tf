variable "aws_region" {
  type        = string
  description = "The AWS region to deploy the capstone cluster"
  default     = "eu-north-1"
}

variable "environment" {
  type        = string
  description = "Environment name for tagging resources"
  default     = "phoenix-capstone"
}

variable "vpc_cidr" {
  type        = string
  description = "The base CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "instance_type" {
  type        = string
  description = "The instance type for our 3 Kubernetes nodes"
  default     = "t3.small"
}

variable "my_public_ip" {
  type        = string
  description = "Your local public IP address with a CIDR mask (e.g., '192.0.2.1/32') for secure SSH access"
}
variable "db_password" {
  type        = string
  description = "The master password for the database instance"
  sensitive   = true
}

variable "db_port" {
  type        = number
  default     = 5432
  description = "The port the database engine listens on"
}
