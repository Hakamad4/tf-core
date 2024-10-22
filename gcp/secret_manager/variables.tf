variable "project_id" {
  description = "The project ID to manage the Secret Manager resources"
  type        = string
}

variable "secrets" {
  description = "The list of the secrets"
  type        = list(map(string))
  default     = []
}

variable "user_managed_replication" {
  description = "Replication parameters that will be used for defined secrets"
  type        = map(list(object({ location = string, kms_key_name = string })))
  default     = {}
}

variable "topics" {
  description = "topics that will be used for defined secrets"
  type        = map(list(object({ name = string })))
  default     = {}
}

variable "labels" {
  description = "labels to be added for the defined secrets"
  type        = map(string)
  default     = {}
}

variable "add_kms_permissions" {
  description = "The list of the crypto keys to give secret manager access to"
  type        = list(string)
  default     = []
}

variable "add_pubsub_permissions" {
  description = "The list of the pubsub topics to give secret manager access to"
  type        = list(string)
  default     = []
}
