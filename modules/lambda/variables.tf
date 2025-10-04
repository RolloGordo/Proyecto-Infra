variable "project_name" {
  description = "Nombre del proyecto para prefijos"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, test, prod)"
  type        = string
}

variable "dynamodb_table_name" {
  description = "Nombre de la tabla DynamoDB"
  type        = string
}

variable "dynamodb_table_arn" {
  description = "ARN de la tabla DynamoDB"
  type        = string
}

variable "sns_topic_arn" {
  description = "ARN del tópico SNS"
  type        = string
}

variable "lambda_s3_bucket" {
  description = "Nombre del bucket S3 donde está almacenado el ZIP del código Lambda"
  type        = string
}

variable "lambda_s3_key" {
  description = "Ruta dentro del bucket S3 para el código Lambda"
  type        = string
}

variable "handler" {
  description = "Punto de entrada de la función Lambda (archivo.funcion)"
  type        = string
  default     = "app.handler"
}

variable "runtime" {
  description = "Runtime de la función Lambda"
  type        = string
  default     = "python3.12"
}

variable "timeout" {
  description = "Tiempo máximo de ejecución en segundos"
  type        = number
  default     = 10
}

variable "memory_size" {
  description = "Memoria asignada a la función Lambda en MB"
  type        = number
  default     = 128
}

variable "sns_topic_arn" {
  description = "ARN del SNS Topic para publicar notificaciones"
  type        = string
}