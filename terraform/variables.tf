variable "aws_access_key_id" {
  description = "The AWS access key ID"
  type        = string
}

variable "aws_secret_access_key" {
  description = "The AWS secret access key"
  type        = string
}
variable "rds_db_name" {
  description = "The name of the RDS database"
  type        = string
}

variable "rds_username" {
  description = "The username for the RDS database"
  type        = string
}

variable "rds_password" {
  description = "The password for the RDS database"
  type        = string
}
