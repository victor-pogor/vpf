variable "postgres_user" {
  description = "The username for the PostgreSQL database"
  type        = string
  default     = "vpf"
}

variable "postgres_password" {
  description = "The password for the PostgreSQL database"
  type        = string
  default     = "*_Not_a_safe_password_*"
}

variable "postgres_db" {
  description = "The name of the PostgreSQL database"
  type        = string
  default     = "vpfinance"
}

variable "postgres_port" {
  description = "The port for the PostgreSQL database"
  type        = number
  default     = 5432
}
