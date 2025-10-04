# ============================================================
# Módulo: SNS - Sistema de Notificaciones
# ============================================================

resource "aws_sns_topic" "this" {
  name = "${var.project_name}-${var.environment}-notifications"

  tags = {
    Name        = "${var.project_name}-${var.environment}-sns"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Ejemplo de suscripción por email (útil para pruebas)
resource "aws_sns_topic_subscription" "email" {
  count     = var.enable_email_subscription ? 1 : 0
  topic_arn = aws_sns_topic.this.arn
  protocol  = "email"
  endpoint  = var.notification_email
}