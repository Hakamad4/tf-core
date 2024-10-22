variable "project_id" {
  type = string
}

variable "triggers" {
  type = list(object({
    name            = string,
    filename        = string,
    disabled        = bool,
    description     = string,
    substitutions   = map(string),
    service_account = string,
    github_pull_request = object({
      comment_control = string,
      branch          = string,
      invert_regex    = bool
    }),
    github_push = object({
      branch       = string,
      invert_regex = bool,
      tag          = string
    }),
    github_name       = string,
    github_owner      = string,
    ignore_files      = list(string),
    included_files    = list(string)
    approval_required = bool
  }))
  default = []
}

variable "roles" {
  type    = list(string)
  default = []
}

variable "enable_api" {
  type    = bool
  default = true
}