output "network" {
  description = "The VPC resource being created"
  value       = google_compute_network.network
}

output "network_name" {
  description = "The name of the VPC being created"
  value       = google_compute_network.network.name
}

output "network_id" {
  description = "The ID of the VPC being created"
  value       = google_compute_network.network.id
}

output "network_self_link" {
  description = "The URI of the VPC being created"
  value       = google_compute_network.network.self_link
}

output "project_id" {
  description = "VPC project id"
  value       = var.shared_vpc_host && length(google_compute_shared_vpc_host_project.shared_vpc_host) > 0 ? google_compute_shared_vpc_host_project.shared_vpc_host.*.project[0] : google_compute_network.network.project
}
