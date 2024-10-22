output "workflow_id" {
  description = "Workflow identifier for the resource with format projects/{{project}}/locations/{{region}}/workflows/{{name}}"
  value       = google_workflows_workflow.main.id
}

output "workflow_revision_id" {
  description = "The revision of the workflow. A new one is generated if the service account or source contents is changed."
  value       = google_workflows_workflow.main.revision_id
}

output "workflow_region" {
  description = "The region of the workflow."
  value       = google_workflows_workflow.main.region
}
