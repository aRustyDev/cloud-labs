output "access_key_id" {
  value = module.start_point.access_key_id
}

output "secret_access_key" {
  sensitive = true
  value     = module.start_point.secret_access_key
}

output "name" {
  value = module.start_point.user_name
}

output "flag_arn" {
  value = module.flags.arn
}

output "target_role_arn" {
  value = module.target_point.role_arn
}

output "secret_arn" {
  value = module.flags.secret_arn
}