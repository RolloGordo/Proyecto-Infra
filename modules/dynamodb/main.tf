# ============================================================
# Módulo: DynamoDB - Base de Datos NoSQL
# ============================================================

resource "aws_dynamodb_table" "this" {
  name         = "${var.project_name}-${var.environment}-table"
  billing_mode = "PAY_PER_REQUEST" # Serverless, sin necesidad de provisionar RCU/WCU
  hash_key     = var.hash_key

  # Clave de partición obligatoria
  attribute {
    name = var.hash_key
    type = "S"
  }

  # Clave de ordenamiento opcional
  dynamic "attribute" {
    for_each = var.sort_key != null ? [var.sort_key] : []
    content {
      name = attribute.value
      type = "S"
    }
  }

  range_key = var.sort_key

  point_in_time_recovery {
    enabled = true
  }

  server_side_encryption {
    enabled = true
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-dynamodb"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}