resource "google_workflows_workflow" "main" {
  project         = var.project_id
  name            = var.name
  region          = var.region
  description     = var.description
  service_account = var.service_account
  source_contents = var.source_contents
  labels          = var.labels

  lifecycle {
    ignore_changes = [source_contents]
  }
}
