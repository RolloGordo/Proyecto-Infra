variable "project_name" {
  description = "Nombre del proyecto para prefijos"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, test, prod)"
  type        = string
}

variable "log_retention_in_days" {
  description = "Tiempo de retención de logs en días"
  type        = number
  default     = 14
}