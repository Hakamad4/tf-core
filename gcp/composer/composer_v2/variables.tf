variable "project_id" {
  type = string
}

variable "name" {
  type = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "labels" {
  type    = map(string)
  default = {}
}

variable "network" {
  type = string
}

variable "network_project_id" {
  type    = string
  default = ""
}

variable "subnetwork" {
  type = string
}

variable "subnetwork_region" {
  type    = string
  default = ""
}

variable "service_account" {
  type    = string
  default = null
}

variable "pod_ip_allocation_range_name" {
  type    = string
  default = null
}

variable "service_ip_allocation_range_name" {
  type    = string
  default = null
}

variable "airflow_config_overrides" {
  type    = map(string)
  default = {}
}

variable "env_variables" {
  type    = map(string)
  default = {}
}

variable "image_version" {
  type    = string
  default = "composer-2.0.2-airflow-2.1.4"
}

variable "pypi_packages" {
  type    = map(string)
  default = {}
}

variable "use_private_environment" {
  type    = bool
  default = false
}

variable "cloud_sql_ipv4_cidr" {
  type    = string
  default = null
}

variable "web_server_ipv4_cidr" {
  type    = string
  default = null
}

variable "master_ipv4_cidr" {
  type    = string
  default = null
}

variable "enable_private_endpoint" {
  type    = bool
  default = false
}

variable "cloud_composer_network_ipv4_cidr_block" {
  type    = string
  default = null
}

variable "web_server_allowed_ip_ranges" {
  default = null
  type = list(object({
    value       = string,
    description = string
  }))
}

variable "maintenance_start_time" {
  type    = string
  default = "05:00"
}

variable "maintenance_end_time" {
  type    = string
  default = null
}

variable "maintenance_recurrence" {
  type    = string
  default = null
}

variable "environment_size" {
  type    = string
  default = "ENVIRONMENT_SIZE_MEDIUM"
}

variable "scheduler" {
  type = object({
    cpu        = string
    memory_gb  = number
    storage_gb = number
    count      = number
  })
  default = {
    cpu        = 2
    memory_gb  = 7.5
    storage_gb = 5
    count      = 2
  }
}

variable "web_server" {
  type = object({
    cpu        = string
    memory_gb  = number
    storage_gb = number
  })
  default = {
    cpu        = 2
    memory_gb  = 7.5
    storage_gb = 5
  }
}

variable "worker" {
  type = object({
    cpu        = string
    memory_gb  = number
    storage_gb = number
    min_count  = number
    max_count  = number
  })
  default = {
    cpu        = 2
    memory_gb  = 7.5
    storage_gb = 5
    min_count  = 2
    max_count  = 6
  }
}

variable "master_authorized_networks" {
  type = list(object({
    cidr_block   = string
    display_name = string
  }))
  default = []
}

variable "grant_sa_agent_permission" {
  type    = bool
  default = true
}
