# ============================================================
# Módulo: API Gateway - Exposición del Backend Lambda
# ============================================================

# Crear la API REST
resource "aws_api_gateway_rest_api" "this" {
  name        = "${var.project_name}-${var.environment}-api"
  description = "API Gateway para ${var.project_name}"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Recurso base /reservas
resource "aws_api_gateway_resource" "reservas" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "reservas"
}

# Método GET en /reservas
resource "aws_api_gateway_method" "get_reservas" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.reservas.id
  http_method   = "GET"
  authorization = "NONE"
}

# Integración con Lambda para GET /reservas
resource "aws_api_gateway_integration" "get_reservas_integration" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.reservas.id
  http_method             = aws_api_gateway_method.get_reservas.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_invoke_arn
}

# Recurso base /suscripciones
resource "aws_api_gateway_resource" "suscripciones" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "suscripciones"
}

# Método POST en /suscripciones
resource "aws_api_gateway_method" "post_suscripciones" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.suscripciones.id
  http_method   = "POST"
  authorization = "NONE"
}

# Integración con Lambda para POST /suscripciones
resource "aws_api_gateway_integration" "post_suscripciones_integration" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.suscripciones.id
  http_method             = aws_api_gateway_method.post_suscripciones.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_invoke_arn
}

# Permitir que API Gateway invoque la Lambda
resource "aws_lambda_permission" "apigw_invoke" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.this.execution_arn}/*/*"
}

# Deployment
resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id

  depends_on = [
    aws_api_gateway_integration.get_reservas_integration,
    aws_api_gateway_integration.post_suscripciones_integration
  ]
}

# Stage asociado al deployment
resource "aws_api_gateway_stage" "this" {
  stage_name    = var.environment
  rest_api_id   = aws_api_gateway_rest_api.this.id
  deployment_id = aws_api_gateway_deployment.this.id
}