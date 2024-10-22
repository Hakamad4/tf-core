variable "project_id" {
  description = "Project id where service account will be created."
  type        = string
}

variable "prefix" {
  description = "Prefix applied to service account names."
  type        = string
  default     = ""
}

variable "names" {
  description = "Names of the service accounts to create."
  type        = list(string)
  default     = []
}

variable "project_roles" {
  description = "Common roles to apply to all service accounts, project=>role as elements."
  type        = list(string)
  default     = []
}

variable "grant_billing_role" {
  description = "Grant billing user role."
  type        = bool
  default     = false
}

variable "billing_account_id" {
  description = "If assigning billing role, specificy a billing account (default is to assign at the organizational level)."
  type        = string
  default     = ""
}

variable "grant_xpn_roles" {
  description = "Grant roles for shared VPC management."
  type        = bool
  default     = true
}

variable "org_id" {
  description = "Id of the organization for org-level roles."
  type        = string
  default     = ""
}

variable "generate_keys" {
  description = "Generate keys for service accounts."
  type        = bool
  default     = false
}

variable "export_key_to_sm" {
  description = "Export key to SM."
  type        = bool
  default     = true
}

variable "display_name" {
  description = "Display names of the created service accounts."
  type        = string
  default     = "Terraform-managed service account"
}

variable "description" {
  description = "Default description of the created service accounts (defaults to no description)"
  type        = string
  default     = ""
}

variable "descriptions" {
  description = "List of descriptions for the created service accounts (elements default to the value of `description`)"
  type        = list(string)
  default     = []
}

variable "labels" {
  description = "labels to be added for the defined secrets"
  type        = map(string)
  default     = {}
}
