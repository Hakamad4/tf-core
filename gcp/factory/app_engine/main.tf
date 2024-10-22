resource "google_app_engine_application" "main" {
  project        = var.project_id
  location_id    = var.location_id
  auth_domain    = var.auth_domain
  serving_status = var.serving_status
  dynamic "feature_settings" {
    for_each = var.feature_settings
    content {
      split_health_checks = lookup(feature_settings.value, "split_health_checks", true)
    }
  }
}
