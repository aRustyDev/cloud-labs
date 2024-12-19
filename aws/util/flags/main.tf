resource "random_string" "flag" {
  length = 16
  lower  = false
}

resource "aws_secretsmanager_secret" "flag" {
  description = "A secret that holds the flag for ${var.tags.lab_id}"
  name        = "${var.lab_name}-flag"
  # kms_key_id = aws_kms_key.key.arn
  force_overwrite_replica_secret = true

  tags = {
    tag-key = var.tags.lab_id
  }
}

resource "aws_secretsmanager_secret_policy" "flag" {
  secret_arn = aws_secretsmanager_secret.flag.arn
  policy     = var.flag_policy_arn
}