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

variable "workflow_id" {
  description = "The resource name of the Workflow whose Executions are triggered by the events. The Workflow resource should be deployed in the same project as the trigger. Format: projects/{project}/locations/{location}/workflows/{workflow}"
  type        = string
}

variable "matching_criteria" {
  description = "The Pub/Sub topic and subscription used by Eventarc as delivery intermediary"
  type = set(object({
    attribute = string
    operator  = optional(string)
    value     = string
  }))
}
variable "service_account" {
  description = "Service Account (projects/{project}/serviceAccounts/{account}) linked to the eventarc"
  type        = string
}

variable "transport" {
  description = "he name of a CloudEvents attribute. Currently, only a subset of attributes are supported for filtering. All triggers MUST provide a filter for the 'type' attribute"
  type = object({
    topic        = string
  })
  default = null
}

variable "labels" {
  description = "Labels to be added for the defined workflow"
  type        = map(string)
  default     = {}
}
