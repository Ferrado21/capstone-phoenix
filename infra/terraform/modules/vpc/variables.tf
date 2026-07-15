variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC"
}

variable "environment" {
  type        = string
  description = "The environment name for resource tagging"
}
variable "db_port" {
  type        = number
  default     = 5432
  description = "The inbound port for the database (e.g., 5432 for Postgres, 3306 for MySQL)"
}
