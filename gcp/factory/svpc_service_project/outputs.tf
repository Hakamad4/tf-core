output "project_name" {
  description = "The name for the project"
  value       = module.project-factory.project_name
}

output "project_id" {
  description = "If provided, the project uses the given project ID. Mutually exclusive with random_project_id being true."
  value       = module.shared_vpc_access.project_id
}

output "project_number" {
  description = "The number for the project"
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
