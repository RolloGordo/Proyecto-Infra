output "lambda_name" {
  description = "Nombre de la función Lambda"
  value       = aws_lambda_function.backend.function_name
}

output "lambda_arn" {
  description = "ARN de la función Lambda"
  value       = aws_lambda_function.backend.arn
}

output "lambda_invoke_arn" {
  description = "ARN de invocación de la Lambda (para API Gateway)"
  value       = aws_lambda_function.backend.invoke_arn
}