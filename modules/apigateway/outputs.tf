output "api_id" {
  description = "ID de la API Gateway"
  value       = aws_api_gateway_rest_api.this.id
}

output "api_url" {
  description = "URL base del API Gateway"
  value       = "${aws_api_gateway_stage.this.invoke_url}"
}