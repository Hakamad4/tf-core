output "domain" {
  description = "The domain of the group's organization."
  value       = local.domain
}

output "email" {
  description = "The email address of the group."
  value       = local.email
}

output "name" {
  description = "The username portion of the email address of the group."
  value       = var.name
}
