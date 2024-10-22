variable "project_id" {
  description = "The project ID to create the workflow in"
  type        = string
}

variable "region" {
  description = "The region to create the workflow in"
  type        = string
  default     = "us-central1"
}

variable "name" {
  description = "Name of the workflow"
  type        = string
}

variable "name_prefix" {
  description = "Creates a unique name beginning with the specified prefix. If this and name are unspecified, a random value is chosen for the name."
  type        = string
  default     = ""
}

variable "description" {
  description = "Description of the workflow provided by the user"
  type        = string
  default     = ""
}

variable "service_account" {
  description = "Service Account (projects/{project}/serviceAccounts/{account}) linked to the workflow"
  type        = string
}

variable "source_contents" {
  description = "Workflow code to be executed. The size limit is 32KB"
  type        = string
  default     = ""
}

variable "labels" {
  description = "Labels to be added for the defined workflow"
  type        = map(string)
  default     = {}
}
