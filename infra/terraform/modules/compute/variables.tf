variable "public_subnet_id" {
  description = "The ID of the public subnet where the EC2 instance will reside"
  type        = string
}

variable "compute_security_group_id" {
  description = "The security group ID assigned to the application server"
  type        = string
}

variable "key_name" {
  description = "The AWS SSH Key Pair name for SSH access"
  type        = string
  default     = ""
}

variable "environment" {
  description = "The environment tag (e.g., phoenix-capstone)"
  type        = string
}
