output "topic_arn" {
  description = "ARN del SNS Topic creado"
  value       = aws_sns_topic.this.arn
}

output "topic_name" {
  description = "Nombre del SNS Topic creado"
  value       = aws_sns_topic.this.name
}