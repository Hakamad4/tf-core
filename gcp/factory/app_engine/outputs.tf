output "name" {
  description = "Unique name of the app, usually apps/{PROJECT_ID}."
  value       = google_app_engine_application.main.name
}

output "url_dispatch_rule" {
  description = "A list of dispatch rule blocks. Each block has a domain, path, and service field."
  value       = google_app_engine_application.main.url_dispatch_rule
}

output "code_bucket" {
  description = "The GCS bucket code is being stored in for this app."
  value       = google_app_engine_application.main.code_bucket
}

output "default_hostname" {
  description = "The default hostname for this app."
  value       = google_app_engine_application.main.default_hostname
}

output "default_bucket" {
  description = "The GCS bucket content is being stored in for this app."
  value       = google_app_engine_application.main.default_bucket
}

output "location_id" {
  description = "The location app engine is serving from"
  value       = google_app_engine_application.main.location_id
}
