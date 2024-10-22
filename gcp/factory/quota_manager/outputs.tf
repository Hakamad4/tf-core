output "quota_overrides" {
  description = "The server-generated names of the quota override."
  value       = google_service_usage_consumer_quota_override.override
}
