output "distribution_id" {
  description = "ID de la distribución de CloudFront"
  value       = aws_cloudfront_distribution.cdn.id
}

output "distribution_domain_name" {
  description = "Dominio público de la distribución CloudFront"
  value       = aws_cloudfront_distribution.cdn.domain_name
}

output "oai_iam_arn" {
  description = "ARN de la Origin Access Identity (OAI)"
  value       = aws_cloudfront_origin_access_identity.oai.iam_arn
}

output "certificate_arn" {
  description = "ARN del certificado SSL generado en ACM"
  value       = aws_acm_certificate.cloudfront_cert.arn
}