output "load_balancer_ip" {
  value       = module.lb-http.external_ip
  description = "IP Address used by Load Balancer."
}

output "revision" {
  value       = module.cloud_run.revision
  description = "Deployed revision for the service."
}

output "service_name" {
  value       = module.cloud_run.service_name
  description = "The name of the deployed service."
}

output "service_url" {
  value       = module.cloud_run.service_url
  description = "The URL on which the deployed service is available."
}

output "service_id" {
  value       = module.cloud_run.service_id
  description = "Unique Identifier for the created service."
}

output "service_status" {
  value       = module.cloud_run.service_status
  description = "Status of the created service."
}

output "domain_map_id" {
  value       = module.cloud_run.domain_map_id
  description = "Unique Identifier for the created domain map."
}

output "domain_map_status" {
  value       = module.cloud_run.domain_map_status
  description = "Status of Domain mapping."
}