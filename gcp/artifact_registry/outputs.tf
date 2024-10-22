output "repositories" {
  description = "The created Artifact Repository repositories."
  value       = google_artifact_registry_repository.repositories
}

output "custom_role_artifact_registry_lister_id" {
  description = "The ID of the custom role for Artifact Registry listers."
  value       = local.custom_role_artifact_registry_lister_id
}
