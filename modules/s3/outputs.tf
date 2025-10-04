output "bucket_name" {
  description = "Nombre del bucket S3 creado para el frontend"
  value       = aws_s3_bucket.frontend.bucket
}

output "bucket_arn" {
  description = "ARN del bucket S3"
  value       = aws_s3_bucket.frontend.arn
}

output "website_endpoint" {
  description = "Endpoint del sitio web estático del bucket"
  value       = aws_s3_bucket_website_configuration.frontend.website_endpoint
}