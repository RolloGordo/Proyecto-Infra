# ============================================================
# Módulo: CloudWatch - Logs de Lambda
# ============================================================

resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${var.project_name}-${var.environment}-lambda"
  retention_in_days = var.log_retention_in_days

  tags = {
    Name        = "${var.project_name}-${var.environment}-lambda-log-group"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}