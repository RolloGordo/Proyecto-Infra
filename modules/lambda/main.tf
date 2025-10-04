# ============================================================
# Módulo: Lambda - Backend Serverless
# ============================================================

# IAM Role para la Lambda
resource "aws_iam_role" "lambda_role" {
  name = "${var.project_name}-${var.environment}-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# Políticas para acceso a DynamoDB y SNS
resource "aws_iam_role_policy" "lambda_policy" {
  name = "${var.project_name}-${var.environment}-lambda-policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
        Effect   = "Allow"
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Action   = ["dynamodb:PutItem", "dynamodb:GetItem", "dynamodb:UpdateItem", "dynamodb:Scan", "dynamodb:Query"]
        Effect   = "Allow"
        Resource = var.dynamodb_table_arn
      },
      {
        Action   = ["sns:Publish"]
        Effect   = "Allow"
        Resource = var.sns_topic_arn
      }
    ]
  })
}

# Función Lambda
resource "aws_lambda_function" "backend" {
  function_name = "${var.project_name}-${var.environment}-lambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = var.handler
  runtime       = var.runtime
  timeout       = var.timeout
  memory_size   = var.memory_size

  # Código desde S3 (evita cargar directamente el ZIP en el repo)
  s3_bucket        = var.lambda_s3_bucket
  s3_key           = var.lambda_s3_key

  environment {
    variables = {
      DYNAMODB_TABLE = var.dynamodb_table_name
      SNS_TOPIC_ARN  = var.sns_topic_arn
    }
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-lambda"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# IAM Role Policy para Lambda con permisos sobre SNS
resource "aws_iam_role_policy" "lambda_sns_policy" {
  name   = "${var.project_name}-${var.environment}-lambda-sns-policy"
  role   = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "sns:Publish"
        ]
        Resource = var.sns_topic_arn
      }
    ]
  })
}

# Lambda function
resource "aws_lambda_function" "this" {
  function_name = "${var.project_name}-${var.environment}-lambda"
  role          = aws_iam_role.lambda_role.arn
  runtime       = var.runtime
  handler       = var.handler
  
  # código desde S3
  s3_bucket = var.lambda_s3_bucket
  s3_key    = var.lambda_s3_key

  timeout     = var.timeout
  memory_size = var.memory_size

  environment {
    variables = {
      DYNAMODB_TABLE = var.dynamodb_table_name
      SNS_TOPIC_ARN  = var.sns_topic_arn
    }
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-lambda"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}