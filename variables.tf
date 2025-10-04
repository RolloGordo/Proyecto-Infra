variable "region" {
  description = "Región donde se desplegarán los recursos de AWS"
  type        = string
  default     = "us-east-1"
}

variable "profile" {
  description = "Perfil de AWS CLI configurado en tu máquina local"
  type        = string
  default     = "default"
}

variable "project_name" {
  description = "Nombre del proyecto para usar como prefijo en los recursos"
  type        = string
  default     = "proyecto-reservas"
}

variable "environment" {
  description = "Entorno de despliegue (dev, test, prod)"
  type        = string
  default     = "dev"
}