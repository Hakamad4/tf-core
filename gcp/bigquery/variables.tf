variable "project_id" {
  type = string
}

variable "dataset_id" {
  type = string
}

variable "dataset_name" {
  type    = string
  default = null
}

variable "description" {
  type    = string
  default = null
}

variable "location" {
  type    = string
  default = "US"
}

variable "delete_contents_on_destroy" {
  type    = bool
  default = null
}

variable "deletion_protection" {
  type    = bool
  default = false
}

variable "default_table_expiration_ms" {
  type    = number
  default = null
}

variable "max_time_travel_hours" {
  type    = number
  default = null
}

variable "encryption_key" {
  type    = string
  default = null
}

variable "dataset_labels" {
  type    = map(string)
  default = {}
}

variable "access" {
  type = any
  default = [{
    role          = "roles/bigquery.dataOwner"
    special_group = "projectOwners"
  }]
}

variable "tables" {
  default = []
  type = list(object({
    table_id      = string,
    description   = optional(string),
    table_name    = optional(string),
    schema        = string,
    max_staleness = optional(string),
    clustering    = optional(list(string)),
    table_constraints = optional(object({
      primary_keys = list(string)
    })),
    time_partitioning = optional(object({
      expiration_ms            = optional(string),
      field                    = string,
      type                     = string,
      require_partition_filter = bool,
    })),
    range_partitioning = optional(object({
      field = string,
      range = object({
        start    = string,
        end      = string,
        interval = string,
      }),
    })),
    expiration_time     = optional(string),
    deletion_protection = optional(bool),
    labels              = map(string),
  }))
}

variable "views" {
  default = []
  type = list(object({
    view_id        = string,
    description    = optional(string),
    query          = string,
    use_legacy_sql = bool,
    labels         = optional(map(string)),
  }))
}

variable "materialized_views" {
  default = []
  type = list(object({
    view_id             = string,
    description         = optional(string),
    query               = string,
    enable_refresh      = bool,
    refresh_interval_ms = string,
    clustering          = optional(list(string)),
    time_partitioning = optional(object({
      expiration_ms            = string,
      field                    = string,
      type                     = string,
      require_partition_filter = bool,
    })),
    range_partitioning = optional(object({
      field = string,
      range = object({
        start    = string,
        end      = string,
        interval = string,
      }),
    })),
    expiration_time = optional(string),
    max_staleness   = optional(string),
    labels          = map(string),
  }))
}

variable "external_tables" {
  default = []
  type = list(object({
    table_id              = string,
    description           = optional(string),
    autodetect            = bool,
    compression           = string,
    ignore_unknown_values = bool,
    max_bad_records       = number,
    schema                = string,
    source_format         = string,
    source_uris           = list(string),
    csv_options = object({
      quote                 = string,
      allow_jagged_rows     = bool,
      allow_quoted_newlines = bool,
      encoding              = string,
      field_delimiter       = string,
      skip_leading_rows     = number,
    }),
    google_sheets_options = object({
      range             = string,
      skip_leading_rows = number,
    }),
    hive_partitioning_options = object({
      mode              = string,
      source_uri_prefix = string,
    }),
    expiration_time     = string,
    max_staleness       = optional(string),
    deletion_protection = optional(bool),
    labels              = map(string),
  }))
}


variable "routines" {
  default = []
  type = list(object({
    routine_id      = string,
    routine_type    = string,
    language        = string,
    definition_body = string,
    return_type     = string,
    description     = string,
    arguments = list(object({
      name          = string,
      data_type     = string,
      argument_kind = string,
      mode          = string,
    })),
  }))
}