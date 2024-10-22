variable "project_id" {
  description = "The GCP project ID that hosts the Artifact Registry."
  type        = string
}

variable "default_location" {
  description = "The default location for the Artifact Registry repositories."
  type        = string
  default     = "southamerica-east1"
}

variable "repositories" {
  description = "List of Artifact Registry repositories to create."
  type = map(object({
    description = string
    format      = optional(string, "DOCKER")
    readers     = optional(list(string), [])
    writers     = optional(list(string), [])
    location    = optional(string, "")
  }))
}

variable "artifact_registry_listers_custom_role_name" {
  description = "Name of the custom role for Artifact Registry listers."
  type        = string
  default     = "custom.artifactRegistryLister"
}

variable "artifact_registry_listers" {
  description = "List of principals that can list Artifact Registry repositories."
  type        = list(string)
  default     = []
}
