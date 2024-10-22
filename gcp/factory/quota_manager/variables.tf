variable "project_id" {
  description = "The GCP project where you want to manage the consumer quotas"
  type        = string
}

variable "consumer_quotas" {
  description = "The quotas configuration you want to override for the project."
  type = list(object({
    service    = string,
    metric     = string,
    dimensions = map(string),
    limit      = string,
    value      = string,
  }))
}
