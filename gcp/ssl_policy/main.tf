resource "google_compute_ssl_policy" "ssl_policy" {
  project         = var.project_id
  name            = var.name
  profile         = var.profile
  min_tls_version = var.min_tls_version
}
