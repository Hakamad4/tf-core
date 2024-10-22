variable "project_id" {
  description = "The project ID to manage the Pub/Sub resources."
  type        = string
}

variable "topic" {
  description = "The Pub/Sub topic name."
  type        = string
}

variable "create_topic" {
  description = "Specify true if you want to create a topic."
  type        = bool
  default     = true
}

variable "create_subscriptions" {
  description = "Specify true if you want to create subscriptions."
  type        = bool
  default     = true
}
variable "topic_labels" {
  description = "A map of labels to assign to the Pub/Sub topic."
  type        = map(string)
  default     = {}
}

variable "push_subscriptions" {
  description = "The list of the push subscriptions."
  type        = list(map(string))
  default     = []
}

variable "pull_subscriptions" {
  description = "The list of the pull subscriptions."
  type        = list(map(string))
  default     = []
}

variable "bigquery_subscriptions" {
  description = "The list of the Bigquery push subscriptions."
  type        = list(map(string))
  default     = []
}

variable "cloud_storage_subscriptions" {
  description = "The list of the Cloud Storage push subscriptions."
  type        = list(map(string))
  default     = []
}

variable "subscription_labels" {
  description = "A map of labels to assign to every Pub/Sub subscription."
  type        = map(string)
  default     = {}
}

variable "topic_message_retention_duration" {
  description = "The minimum duration in seconds to retain a message after it is published to the topic."
  type        = string
  default     = null
}

variable "message_storage_policy" {
  description = "A map of storage policies. Default - inherit from organization's Resource Location Restriction policy."
  type        = map(any)
  default     = {}
}

variable "topic_kms_key_name" {
  description = "The resource name of the Cloud KMS CryptoKey to be used to protect access to messages published on this topic."
  type        = string
  default     = null
}

variable "grant_bigquery_project_roles" {
  description = "Specify true if you want to add bigquery.metadataViewer and bigquery.dataEditor roles to the default Pub/Sub SA."
  type        = bool
  default     = true
}

variable "grant_token_creator" {
  description = "Specify true if you want to add token creator role to the default Pub/Sub SA."
  type        = bool
  default     = true
}

variable "schema" {
  description = "Schema for the topic."
  type = object({
    name       = string
    type       = string
    definition = string
    encoding   = string
  })
  default = null
}
