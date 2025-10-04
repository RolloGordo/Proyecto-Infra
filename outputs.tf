output "s3_bucket_name" {
  description = "Nombre del bucket S3 para el frontend"
  value       = module.s3_frontend.bucket_name
}

output "cloudfront_url" {
  description = "URL de distribución de CloudFront"
  value       = module.cloudfront.distribution_domain_name
}

output "api_gateway_url" {
  description = "Endpoint del API Gateway"
  value       = module.apigateway.api_url
}

output "sns_topic_arn" {
  description = "ARN del tópico SNS configurado"
  value       = module.sns.topic_arn
}