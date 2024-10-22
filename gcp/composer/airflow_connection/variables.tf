variable "project_id" {
  type = string
}

variable "composer_name" {
  type = string
}

variable "id" {
  type = string
}

variable "region" {
  type = string
}

variable "host" {
  type    = string
  default = null
}

variable "uri" {
  type    = string
  default = null
}

variable "login" {
  type    = string
  default = null
}

variable "password" {
  type    = string
  default = null
}

variable "port" {
  type    = string
  default = null
}

variable "schema" {
  type    = string
  default = null
}

variable "type" {
  type    = string
  default = null
}

variable "service_account_key_file" {
  type    = string
  default = "/var/secrets/google-sa/project-factory-sa.json"
}

variable "extra" {
  type    = any
  default = null
}
