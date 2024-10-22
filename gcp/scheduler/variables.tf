variable "project_id" {
  description = "The project ID to create the scheduler job in"
  type        = string
}

variable "name" {
  description = "Name of the job scheduler"
  type        = string
}

variable "region" {
  description = "Region of the cloud scheduler job"
  type        = string
  default     = "us-central1"
}

variable "description" {
  description = "Description of the job"
  type        = string
  default     = null
}

variable "schedule" {
  description = "Cron job scheduler"
  type        = string
}

variable "paused" {
  description = "Enable/Disable scheduler"
  type        = bool
  default     = false
}

variable "time_zone" {
  description = "Time zone of the cloud job scheduler"
  type        = string
  default     = "America/Sao_Paulo"
}

variable "attempt_deadline" {
  description = "The deadline for job attempts. If the request handler does not respond by this deadline then the request is cancelled and the attempt is marked as a DEADLINE_EXCEEDED failure. The failed attempt can be viewed in execution logs. Cloud Scheduler will retry the job according to the RetryConfig."
  type        = string
  default     = "320s"
}

variable "http_target" {
  description = "HTTP Target trigger."
  type = object({
    uri                               = string
    http_method                       = string
    body                              = optional(string, null)
    headers                           = optional(map(string), {})
    oauth_token_service_account_email = optional(string, null)
    oauth_token_scope                 = optional(string, null)
    oidc_token_service_account_email  = optional(string, null)
    oidc_token_audience               = optional(string, null)
  })
  default = null
}

variable "pubsub_target" {
  description = "PubSub Target trigger."
  type = object({
    topic_name = string
    data       = optional(string, null)
    attributes = optional(map(string), {})
  })
  default = null
}

variable "retry_config" {
  description = "Retry config."
  type = object({
    retry_count          = number
    max_backoff_duration = string
    max_doublings        = number
    max_retry_duration   = string
    min_backoff_duration = string
  })
  default = null
}
