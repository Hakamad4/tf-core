locals {
  service_account_list = compact(
    concat(
      google_service_account.cluster_service_account[*].email,
      ["dummy"],
    ),
  )
  service_account_default_name = var.create_service_account && var.service_account_name == "" ? "tf-gke-${substr(var.name, 0, min(15, length(var.name)))}-${random_string.cluster_service_account_suffix[0].result}" : null

  service_account = (var.service_account == "" || var.service_account == "create") && var.create_service_account ? local.service_account_list[0] : var.service_account

  registry_projects_list = length(var.registry_project_ids) == 0 ? [var.project_id] : var.registry_project_ids
}

resource "random_string" "cluster_service_account_suffix" {
  count   = var.create_service_account && var.service_account_name == "" ? 1 : 0
  upper   = false
  lower   = true
  special = false
  length  = 4
}

resource "google_service_account" "cluster_service_account" {
  count        = var.create_service_account ? 1 : 0
  project      = var.project_id
  account_id   = var.service_account_name == "" ? local.service_account_default_name : var.service_account_name
  display_name = "Terraform-managed service account for cluster ${var.name}"
}

resource "google_project_iam_member" "cluster_service_account-nodeService_account" {
  count   = var.create_service_account ? 1 : 0
  project = google_service_account.cluster_service_account[0].project
  role    = "roles/container.defaultNodeServiceAccount"
  member  = google_service_account.cluster_service_account[0].member
}

resource "google_project_iam_member" "cluster_service_account-metric_writer" {
  count   = var.create_service_account ? 1 : 0
  project = google_service_account.cluster_service_account[0].project
  role    = "roles/monitoring.metricWriter"
  member  = google_service_account.cluster_service_account[0].member
}

resource "google_project_iam_member" "cluster_service_account-resourceMetadata-writer" {
  count   = var.create_service_account ? 1 : 0
  project = google_service_account.cluster_service_account[0].project
  role    = "roles/stackdriver.resourceMetadata.writer"
  member  = google_service_account.cluster_service_account[0].member
}

resource "google_project_iam_member" "cluster_service_account-gcr" {
  for_each = var.create_service_account && var.grant_registry_access ? toset(local.registry_projects_list) : []
  project  = each.key
  role     = "roles/storage.objectViewer"
  member   = "serviceAccount:${google_service_account.cluster_service_account[0].email}"
}

resource "google_project_iam_member" "cluster_service_account-artifact-registry" {
  for_each = var.create_service_account && var.grant_registry_access ? toset(local.registry_projects_list) : []
  project  = each.key
  role     = "roles/artifactregistry.reader"
  member   = "serviceAccount:${google_service_account.cluster_service_account[0].email}"
}