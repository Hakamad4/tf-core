variable "project_id" {
  description = "O ID do projeto ao qual o recurso pertence."
  type        = string
}

variable "random_resource_name" {
  description = "Define o sufixo aleatório no final do nome do recurso."
  type        = bool
  default     = true
}

variable "name" {
  description = "Nome da ApiKey."
  type        = string
}

variable "display_name" {
  description = "Nome amigável do recurso."
  type        = string
  default     = null
}

variable "api_targets" {
  description = "Lista de apis que serão utilizadas com a ApiKey."
  type = list(object({
    service = string,
    methods = list(string)
  }))
}

variable "allowed_ip" {
  description = "Lista de IP's que serão liberados com a ApiKey."
  type        = list(string)
  default     = null
}

variable "android_allowed_applications" {
  description = "Lista de app android que serão liberados com a ApiKey."
  type = list(object({
    package_name     = string,
    sha1_fingerprint = string
  }))
  default = null
}

variable "ios_allowed_bundle_ids" {
  description = "Lista de bundle ids que serão liberados com a ApiKey."
  type        = list(string)
  default     = null
}

variable "browser_allowed_restrictions" {
  description = "Lista de Referrers que serão liberados com a ApiKey."
  type        = list(string)
  default     = null
}
