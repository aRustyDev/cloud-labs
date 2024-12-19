output "access_key_id" {
  value = aws_iam_access_key.start.id
}

output "secret_access_key" {
  sensitive = true
  value     = aws_iam_access_key.start.secret
}

output "user_name" {
  value = aws_iam_user.start.name
}