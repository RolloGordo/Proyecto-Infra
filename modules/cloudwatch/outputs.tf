output "cloudwatch_log_group_name" {
  description = "Nombre del Log Group en CloudWatch"
  value       = aws_cloudwatch_log_group.lambda.name
}