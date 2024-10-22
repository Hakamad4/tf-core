locals {
  member_and_role_per_repo = {
    for item in flatten([
      for repository_id, repository in var.repositories : concat([
        for reader in repository.readers : {
          "repository_id" : repository_id,
          "role" : "roles/artifactregistry.reader",
          "member" : reader,
        }
        ], [
        for writer in repository.writers : {
          "repository_id" : repository_id,
          "role" : "roles/artifactregistry.writer",
          "member" : writer,
        }
      ])
    ]) : "${item.repository_id}--${item.role}--${item.member}" =>
    {
      "repository_id" : item.repository_id,
      "role" : item.role,
      "member" : item.member,
    }
  }
  custom_role_artifact_registry_lister_id = "projects/${var.project_id}/roles/${var.artifact_registry_listers_custom_role_name}"
}

resource "google_artifact_registry_repository" "repositories" {
  for_each = var.repositories

  project       = var.project_id
  repository_id = each.key
  location      = each.value.location != "" ? each.value.location : var.default_location
  format        = each.value.format
  description   = each.value.description
}

resource "google_artifact_registry_repository_iam_member" "member" {
  for_each = local.member_and_role_per_repo

  project    = var.project_id
  repository = google_artifact_registry_repository.repositories[each.value.repository_id].name
  location   = google_artifact_registry_repository.repositories[each.value.repository_id].location
  role       = each.value.role
  member     = each.value.member
}

resource "google_project_iam_custom_role" "artifact_registry_lister" {
  count = length(var.artifact_registry_listers)

  role_id     = var.artifact_registry_listers_custom_role_name
  title       = "Artifact Registry Lister"
  description = "This role grants the ability to list repositories in Artifact Registry"
  permissions = ["artifactregistry.repositories.list"]
}

resource "google_project_iam_binding" "artifact_registry_lister" {
  count = length(var.artifact_registry_listers)

  project    = var.project_id
  role       = local.custom_role_artifact_registry_lister_id
  members    = var.artifact_registry_listers
  depends_on = [google_project_iam_custom_role.artifact_registry_lister]
}