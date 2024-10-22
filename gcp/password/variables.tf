variable "project_id" {
  description = "GCP Project Id"
  type        = string
}

variable "password_length" {
  description = "The length of the string desired"
  type        = number
}

variable "save" {
  description = "If Save password in Secrets Manager"
  type        = bool
  default     = true
}

variable "special_char" {
  description = "Include special characters in the result"
  type        = bool
  default     = true
}

variable "lower" {
  description = "Include lowercase alphabet characters in the result"
  type        = bool
  default     = true
}

variable "upper" {
  description = "Include uppercase alphabet characters in the result"
  type        = bool
  default     = true
}

variable "numeric" {
  description = "Include numeric characters in the result"
  type        = bool
  default     = true
}

variable "override_special" {
  description = "Supply your own list of special characters to use for string generation. This overrides the default character list in the special argument"
  type        = string
  default     = null
}

variable "min_lower" {
  description = "Minimum number of lowercase alphabet characters in the result"
  type        = number
  default     = 0
}

variable "min_numeric" {
  description = "Minimum number of numeric characters in the result"
  type        = number
  default     = 0
}

variable "min_special" {
  description = "Minimum number of special characters in the result"
  type        = number
  default     = 0
}

variable "min_upper" {
  description = "Minimum number of uppercase alphabet characters in the result"
  type        = number
  default     = 0
}

variable "secret_name" {
  description = "The name of the secret"
  type        = string
  default     = null
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

variable "automatic_replication" {
  description = "The Secret will automatically be replicated without any restrictions"
  type        = bool
  default     = true
}