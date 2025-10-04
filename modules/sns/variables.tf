variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, test, prod)"
  type        = string
}

variable "enable_email_subscription" {
  description = "Si se debe habilitar la suscripción por email"
  type        = bool
  default     = false
}

variable "notification_email" {
  description = "Email que recibirá las notificaciones SNS"
  type        = string
  default     = ""
}