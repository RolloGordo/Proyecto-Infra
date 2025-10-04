# ------------------------
# Módulo S3 (Frontend)
# ------------------------
module "s3_frontend" {
  source       = "./modules/s3"
  project_name = var.project_name
  environment  = var.environment
}

# ------------------------
# Módulo CloudFront (CDN)
# ------------------------
module "cloudfront" {
  source          = "./modules/cloudfront"
  s3_bucket_name  = module.s3_frontend.bucket_name
  project_name    = var.project_name
  environment     = var.environment
}

# ------------------------
# Módulo DynamoDB
# ------------------------
module "dynamodb" {
  source       = "./modules/dynamodb"
  project_name = var.project_name
  environment  = var.environment
}

# ------------------------
# Módulo Lambda (Backend)
# ------------------------
module "lambda_backend" {
  source           = "./modules/lambda"
  project_name     = var.project_name
  environment      = var.environment
  dynamodb_table   = module.dynamodb.table_name
  sns_topic_arn    = module.sns.topic_arn
}

# ------------------------
# Módulo API Gateway
# ------------------------
module "apigateway" {
  source          = "./modules/apigateway"
  lambda_arn      = module.lambda_backend.lambda_arn
  project_name    = var.project_name
  environment     = var.environment
}

# ------------------------
# Módulo SNS
# ------------------------
module "sns" {
  source       = "./modules/sns"
  project_name = var.project_name
  environment  = var.environment
}

# ------------------------
# Módulo CloudWatch (Logs y métricas)
# ------------------------
module "cloudwatch" {
  source       = "./modules/cloudwatch"
  lambda_name  = module.lambda_backend.lambda_name
  project_name = var.project_name
  environment  = var.environment
}