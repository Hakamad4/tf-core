output "service_name" {
  description = "Name of the created service"
  value       = google_cloud_run_service.main.name
}

output "revision" {
  description = "Deployed revision for the service"
  value       = google_cloud_run_service.main.status[0].latest_ready_revision_name
}

output "service_url" {
  description = "The URL on which the deployed service is available"
  value       = google_cloud_run_service.main.status[0].url
}

output "project_id" {
  description = "Google Cloud project in which the service was created"
  value       = google_cloud_run_service.main.project
}

output "location" {
  description = "Location in which the Cloud Run service was created"
  value       = google_cloud_run_service.main.location
}

output "service_id" {
  description = "Unique Identifier for the created service"
  value       = google_cloud_run_service.main.id
}

output "service_status" {
  description = "Status of the created service"
  value       = google_cloud_run_service.main.status[0].conditions[0].type
}

output "domain_map_id" {
  description = "Unique Identifier for the created domain map"
  value       = values(google_cloud_run_domain_mapping.domain_map)[*].id
}

output "domain_map_status" {
  description = "Status of Domain mapping"
  value       = values(google_cloud_run_domain_mapping.domain_map)[*].status
}

output "verified_domain_name" {
  description = "List of Custom Domain Name"
  value       = values(google_cloud_run_domain_mapping.domain_map)[*].name
}
