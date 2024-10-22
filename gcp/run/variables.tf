variable "project_id" {
  description = "The project ID to deploy to"
  type        = string
}

variable "service_name" {
  description = "The name of the Cloud Run service to create"
  type        = string
}

variable "location" {
  description = "Cloud Run service deployment location"
  type        = string
}

variable "image" {
  description = "GCR hosted image URL to deploy"
  type        = string
}

variable "generate_revision_name" {
  description = "Option to enable revision name generation"
  type        = bool
  default     = true
}

variable "traffic_split" {
  description = "Managing traffic routing to the service"
  type = list(object({
    latest_revision = bool
    percent         = number
    revision_name   = string
    tag             = string
  }))
  default = [{
    latest_revision = true
    percent         = 100
    revision_name   = "v1-0-0"
    tag             = null
  }]
}

variable "service_labels" {
  description = "A set of key/value label pairs to assign to the service"
  type        = map(string)
  default     = {}
}

variable "service_annotations" {
  description = "Annotations to the service. Acceptable values all, internal, internal-and-cloud-load-balancing"
  type        = map(string)
  default = {
    "run.googleapis.com/ingress" = "all"
  }
}

variable "template_labels" {
  description = "A set of key/value label pairs to assign to the container metadata"
  type        = map(string)
  default     = {}
}

variable "template_annotations" {
  description = "Annotations to the container metadata including VPC Connector and SQL. See [more details](https://cloud.google.com/run/docs/reference/rpc/google.cloud.run.v1#revisiontemplate)"
  type        = map(string)
  default = {
    "run.googleapis.com/client-name"   = "terraform"
    "generated-by"                     = "terraform"
    "autoscaling.knative.dev/maxScale" = 2
    "autoscaling.knative.dev/minScale" = 1
  }
}

variable "encryption_key" {
  description = "CMEK encryption key self-link expected in the format projects/PROJECT/locations/LOCATION/keyRings/KEY-RING/cryptoKeys/CRYPTO-KEY."
  type        = string
  default     = null
}

variable "container_concurrency" {
  description = "Concurrent request limits to the service"
  type        = number
  default     = null
}

variable "timeout_seconds" {
  description = "Timeout for each request"
  type        = number
  default     = 120
}

variable "service_account_email" {
  description = "Service Account email needed for the service"
  type        = string
  default     = ""
}

variable "volumes" {
  description = "[Beta] Volumes needed for environment variables (when using secret)"
  type = list(object({
    name = string
    secret = set(object({
      secret_name = string
      items       = map(string)
    }))
  }))
  default = []
}

variable "limits" {
  description = "Resource limits to the container"
  type        = map(string)
  default     = null
}
variable "requests" {
  description = "Resource requests to the container"
  type        = map(string)
  default     = {}
}

variable "ports" {
  description = "Port which the container listens to (http1 or h2c)"
  type = object({
    name = string
    port = number
  })
  default = {
    name = "http1"
    port = 8080
  }
}

variable "argument" {
  description = "Arguments passed to the ENTRYPOINT command, include these only if image entrypoint needs arguments"
  type        = list(string)
  default     = []
}

variable "container_command" {
  description = "Leave blank to use the ENTRYPOINT command defined in the container image, include these only if image entrypoint should be overwritten"
  type        = list(string)
  default     = []
}

variable "env_vars" {
  description = "Environment variables (cleartext)"
  type = list(object({
    value = string
    name  = string
  }))
  default = []
}

variable "env_secret_vars" {
  description = "[Beta] Environment variables (Secret Manager)"
  type = list(object({
    name = string
    value_from = set(object({
      secret_key_ref = map(string)
    }))
  }))
  default = []
}

variable "volume_mounts" {
  description = "[Beta] Volume Mounts to be attached to the container (when using secret)"
  type = list(object({
    mount_path = string
    name       = string
  }))
  default = []
}

variable "verified_domain_name" {
  description = "List of Custom Domain Name"
  type        = list(string)
  default     = []
}

variable "force_override" {
  description = "Option to force override existing mapping"
  type        = bool
  default     = false
}

variable "certificate_mode" {
  description = "The mode of the certificate (NONE or AUTOMATIC)"
  type        = string
  default     = "NONE"
}

variable "domain_map_labels" {
  description = "A set of key/value label pairs to assign to the Domain mapping"
  type        = map(string)
  default     = {}
}

variable "domain_map_annotations" {
  description = "Annotations to the domain map"
  type        = map(string)
  default     = {}
}

variable "members" {
  description = "Users/SAs to be given invoker access to the service"
  type        = list(string)
  default     = []
}
