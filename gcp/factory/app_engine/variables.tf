variable "project_id" {
  description = "The project to enable app engine on."
  type        = string
}

variable "location_id" {
  description = "The location to serve the app from."
  default     = ""
  type        = string
}

variable "auth_domain" {
  description = "The domain to authenticate users with when using App Engine's User API."
  default     = ""
  type        = string
}

variable "serving_status" {
  description = "The serving status of the app."
  default     = "SERVING"
  type        = string
}

variable "feature_settings" {
  description = "A list of maps of optional settings to configure specific App Engine features."
  type        = list(object({ split_health_checks = bool }))
  default     = [{ split_health_checks = true }]
}
