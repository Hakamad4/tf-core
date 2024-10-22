output "function_uri" {
  description = "URI of the Cloud Function (Gen 2)"
  value       = google_cloudfunctions2_function.function.service_config[0].uri
}

output "function_name" {
  description = "Name of the Cloud Function (Gen 2)"
  value       = var.function_name
}
