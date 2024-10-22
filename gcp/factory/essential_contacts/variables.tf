variable "project_id" {
  description = "The GCP project you want to send Essential Contacts notifications for"
  type        = string
}

variable "essential_contacts" {
  description = "A mapping of users or groups to be assigned as Essential Contacts to the project, specifying a notification category"
  type        = map(list(string))
  default     = {}
}

variable "language_tag" {
  description = "Language code to be used for essential contacts notifiactions"
  type        = string
}
