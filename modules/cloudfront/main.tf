# ============================================================
# Módulo: CloudFront - CDN para el Frontend Estático
# ============================================================

# Obtener la cuenta actual (para crear OAI correctamente)
data "aws_caller_identity" "current" {}

# Crear Origin Access Identity (OAI) para restringir acceso directo al bucket
resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "Access Identity for CloudFront to access ${var.s3_bucket_name}"
}

# Certificado SSL para HTTPS (usando ACM en us-east-1)
# ⚠️ IMPORTANTE: CloudFront solo acepta certificados de ACM en us-east-1
resource "aws_acm_certificate" "cloudfront_cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = {
    Name        = "${var.project_name}-${var.environment}-cert"
    Environment = var.environment
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Distribución de CloudFront
resource "aws_cloudfront_distribution" "cdn" {
  enabled             = true
  comment             = "CDN for ${var.project_name} frontend"
  default_root_object = "index.html"

  origin {
    domain_name = "${var.s3_bucket_name}.s3.amazonaws.com"
    origin_id   = "S3-${var.s3_bucket_name}"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${var.s3_bucket_name}"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100" # Más económico (solo USA, Canadá, Europa)

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.cloudfront_cert.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-cdn"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }

  depends_on = [aws_acm_certificate.cloudfront_cert]
}