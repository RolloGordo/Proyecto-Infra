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
  project_name         = var.project_name
  environment          = var.environment
  dynamodb_table_name  = module.dynamodb.table_name
  dynamodb_table_arn   = module.dynamodb.table_arn
  lambda_s3_bucket     = module.s3_frontend.bucket_name
  lambda_s3_key        = "build/lambda.zip"
  sns_topic_arn        = module.sns.topic_arn
}

# ------------------------
# Módulo API Gateway
# ------------------------
module "apigateway" {
  source          = "./modules/apigateway"
  lambda_name        = module.lambda_backend.lambda_name
  lambda_invoke_arn  = module.lambda_backend.lambda_invoke_arn
  project_name       = var.project_name
  environment        = var.environment
}

# ------------------------
# Módulo SNS
# ------------------------
module "sns" {
  source       = "./modules/sns"
  project_name = var.project_name
  environment  = var.environment
  enable_email_subscription = true
  notification_email        = "hfsv123456@gmail.com"
}

# ------------------------
# Módulo CloudWatch (Logs y métricas)
# ------------------------
module "cloudwatch" {
  source       = "./modules/cloudwatch"
  project_name         = var.project_name
  environment          = var.environment
  log_retention_in_days = 14
}