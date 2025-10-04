variable "project_name" {
  description = "Nombre del proyecto para prefijos"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, test, prod)"
  type        = string
}

variable "s3_bucket_name" {
  description = "Nombre del bucket S3 de origen"
  type        = string
}

variable "domain_name" {
  description = "Dominio o subdominio asociado al certificado SSL de CloudFront"
  type        = string
  default     = "example.com"
}