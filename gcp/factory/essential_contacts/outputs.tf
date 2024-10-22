output "essential_contacts" {
  description = "Essential Contact resources created"
  value       = [for contact in google_essential_contacts_contact.contact : contact.name]
}

output "project_id" {
  description = "The GCP project you want to enable APIs on"
  value       = var.project_id
}
