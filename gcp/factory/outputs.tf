
output "project_name" {
  description = "Name of the project"
  value       = module.project-factory.project_name
}

output "project_id" {
  description = "ID of the project"
  value       = module.project-factory.project_id
}

output "project_number" {
  description = "Numeric identifier for the project"
  value       = module.project-factory.project_number
}

output "domain" {
  description = "The organization's domain"
  value       = module.gsuite_group.domain
}

output "group_email" {
  description = "The email of the G Suite group with group_name"
  value       = module.gsuite_group.email
}

output "service_account_id" {
  description = "The id of the default service account"
  value       = module.project-factory.service_account_id
}

output "service_account_display_name" {
  description = "The display name of the default service account"
  value       = module.project-factory.service_account_display_name
}

output "service_account_email" {
  description = "The email of the default service account"
  value       = module.project-factory.service_account_email
}

output "service_account_name" {
  description = "The fully-qualified name of the default service account"
  value       = module.project-factory.service_account_name
}

output "service_account_unique_id" {
  description = "The unique id of the default service account"
  value       = module.project-factory.service_account_unique_id
}

output "project_bucket_self_link" {
  description = "Project's bucket selfLink"
  value       = module.project-factory.project_bucket_self_link
}

output "project_bucket_url" {
  description = "Project's bucket url"
  value       = module.project-factory.project_bucket_url
}

output "api_s_account" {
  description = "API service account email"
  value       = module.project-factory.api_s_account
}

output "api_s_account_fmt" {
  description = "API service account email formatted for terraform use"
  value       = module.project-factory.api_s_account_fmt
}

output "enabled_apis" {
  description = "Enabled APIs in the project"
  value       = module.project-factory.enabled_apis
}

output "enabled_api_identities" {
  description = "Enabled API identities in the project"
  value       = module.project-factory.enabled_api_identities
}

output "budget_name" {
  description = "The name of the budget if created"
  value       = module.budget.name
}
