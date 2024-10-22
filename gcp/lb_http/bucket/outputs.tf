output "name" {
  value = var.name
}

output "external_ip" {
  value = local.address
}

output "http_proxy" {
  value = google_compute_target_http_proxy.default[*].self_link
}

output "https_proxy" {
  value = google_compute_target_https_proxy.default[*].self_link
}

output "backend_bucket_name" {
  value = google_compute_backend_bucket.default_backend_bucket.self_link
}
