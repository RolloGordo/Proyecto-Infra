variable "project_name" {
  description = "Nombre del proyecto para prefijos"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, test, prod)"
  type        = string
}

variable "hash_key" {
  description = "Clave de partición principal"
  type        = string
  default     = "id"
}

variable "sort_key" {
  description = "Clave de ordenamiento (opcional)"
  type        = string
  default     = null
}