output "sns_topic_arn" {
  description = "ARN del SNS Topic creado"
  value       = aws_sns_topic.this.arn
}

output "sns_topic_name" {
  description = "Nombre del SNS Topic creado"
  value       = aws_sns_topic.this.name
}