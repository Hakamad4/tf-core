variable "project_id" {
  description = "The project where cloud run is going to be deployed."
  type        = string
}

variable "location" {
  description = "The location where resources are going to be deployed."
  type        = string
}

variable "service_name" {
  description = "The name of the Cloud Run service to create."
  type        = string
}

variable "serverless_neg" {
  description = "The name of the Serverless neg."
  type        = string
  default     = ""
}

variable "image" {
  description = "GAR hosted image URL to deploy."
  type        = string
}

variable "cloud_run_sa" {
  description = "Service account to be used on Cloud Run."
  type        = string
}

variable "vpc_connector_id" {
  description = "VPC Connector id in the format projects/PROJECT/locations/LOCATION/connectors/NAME."
  type        = string
}

variable "encryption_key" {
  description = "CMEK encryption key self-link expected in the format projects/PROJECT/locations/LOCATION/keyRings/KEY-RING/cryptoKeys/CRYPTO-KEY."
  type        = string
  default     = null
}

variable "region" {
  description = "Location for load balancer and Cloud Run resources."
  type        = string
}

variable "default_rules" {
  description = "Default rule for Cloud Armor."
  default = {
    default_rule = {
      action         = "allow"
      priority       = "2147483647"
      versioned_expr = "SRC_IPS_V1"
      src_ip_ranges  = ["*"]
      description    = "Default allow all rule"
    }
  }
  type = map(object({
    action         = string
    priority       = string
    versioned_expr = string
    src_ip_ranges  = list(string)
    description    = string
  }))
}

variable "owasp_rules" {
  description = "These are additional Cloud Armor rules for SQLi, XSS, LFI, RCE, RFI, Scannerdetection, Protocolattack and Sessionfixation (requires Cloud Armor default_rule)."
  default = {
    rule_sqli = {
      action     = "deny(403)"
      priority   = "1000"
      expression = "evaluatePreconfiguredExpr('sqli-v33-stable')"
    }
    rule_xss = {
      action     = "deny(403)"
      priority   = "1001"
      expression = "evaluatePreconfiguredExpr('xss-v33-stable')"
    }
    rule_lfi = {
      action     = "deny(403)"
      priority   = "1002"
      expression = "evaluatePreconfiguredExpr('lfi-v33-stable')"
    }
    rule_canary = {
      action     = "deny(403)"
      priority   = "1003"
      expression = "evaluatePreconfiguredExpr('rce-v33-stable')"
    }
    rule_rfi = {
      action     = "deny(403)"
      priority   = "1004"
      expression = "evaluatePreconfiguredExpr('rfi-v33-stable')"
    }
    rule_scannerdetection = {
      action     = "deny(403)"
      priority   = "1005"
      expression = "evaluatePreconfiguredExpr('scannerdetection-v33-stable')"
    }
    rule_protocolattack = {
      action     = "deny(403)"
      priority   = "1006"
      expression = "evaluatePreconfiguredExpr('protocolattack-v33-stable')"
    }
    rule_sessionfixation = {
      action     = "deny(403)"
      priority   = "1007"
      expression = "evaluatePreconfiguredExpr('sessionfixation-v33-stable')"
    }
  }
  type = map(object({
    action     = string
    priority   = string
    expression = string
  }))
}

variable "lb_name" {
  description = "Name for load balancer and associated resources."
  default     = "tf-cr-lb"
}

variable "http_forward" {
  description = "Enable HTTP forward."
  type        = bool
  default     = false
}

variable "env_vars" {
  description = "Environment variables."
  type = list(object({
    value = string
    name  = string
  }))
  default = []
}

variable "members" {
  description = "Users/SAs to be given invoker access to the service with the prefix `serviceAccount:' for SAs and `user:` for users."
  type        = list(string)
  default     = ["allUsers"]
}

variable "generate_revision_name" {
  description = "Option to enable revision name generation."
  type        = bool
  default     = true
}

variable "traffic_split" {
  description = "Managing traffic routing to the service."
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
  description = "A set of key/value label pairs to assign to the service."
  type        = map(string)
  default     = {}
}

variable "template_labels" {
  description = "A set of key/value label pairs to assign to the container metadata."
  type        = map(string)
  default     = {}
}

variable "container_concurrency" {
  description = "Concurrent request limits to the service."
  type        = number
  default     = null
}

variable "timeout_seconds" {
  description = "Timeout for each request."
  type        = number
  default     = 120
}

variable "volumes" {
  description = "[Beta] Volumes needed for environment variables (when using secret)."
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
  description = "Resource limits to the container."
  type        = map(string)
  default     = null
}
variable "requests" {
  description = "Resource requests to the container."
  type        = map(string)
  default     = {}
}

variable "ports" {
  description = "Port which the container listens to (http1 or h2c)."
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
  description = "Arguments passed to the ENTRYPOINT command, include these only if image entrypoint needs arguments."
  type        = list(string)
  default     = []
}

variable "container_command" {
  description = "Leave blank to use the ENTRYPOINT command defined in the container image, include these only if image entrypoint should be overwritten."
  type        = list(string)
  default     = []
}

variable "volume_mounts" {
  type = list(object({
    mount_path = string
    name       = string
  }))
  description = "[Beta] Volume Mounts to be attached to the container (when using secret)."
  default     = []
}

variable "verified_domain_name" {
  description = "List of custom Domain Name."
  type        = list(string)
  default     = []
}

variable "force_override" {
  description = "Option to force override existing mapping."
  type        = bool
  default     = false
}

variable "certificate_mode" {
  description = "The mode of the certificate (NONE or AUTOMATIC)."
  type        = string
  default     = "NONE"
}

variable "domain_map_labels" {
  description = "A set of key/value label pairs to assign to the Domain mapping."
  type        = map(string)
  default     = {}
}

variable "domain_map_annotations" {
  description = "Annotations to the domain map."
  type        = map(string)
  default     = {}
}

variable "create_cloud_armor_policies" {
  description = "When `true`, the terraform will create the Cloud Armor policies. When `false`, the user must provide their own Cloud Armor name in `cloud_armor_policies_name`."
  type        = bool
  default     = false
}

variable "cloud_armor_policies_name" {
  description = "Cloud Armor policy name already created in the project. If `create_cloud_armor_policies` is `false`, this variable must be provided, If `create_cloud_armor_policies` is `true`, this variable will be ignored."
  type        = string
  default     = ""
}

variable "max_scale_instances" {
  description = "Sets the maximum number of container instances needed to handle all incoming requests or events from each revison from Cloud Run. For more information, access this [documentation](https://cloud.google.com/run/docs/about-instance-autoscaling)."
  type        = number
  default     = 2
}

variable "min_scale_instances" {
  description = "Sets the minimum number of container instances needed to handle all incoming requests or events from each revison from Cloud Run. For more information, access this [documentation](https://cloud.google.com/run/docs/about-instance-autoscaling)."
  type        = number
  default     = 1
}

variable "ssl_policy" {
  description = "Selfink to SSL Policy"
  type        = string
  default     = null
}

variable "vpc_egress_value" {
  description = "Sets VPC Egress firewall rule. Supported values are all-traffic, all (deprecated), and private-ranges-only. all-traffic and all provide the same functionality. all is deprecated but will continue to be supported. Prefer all-traffic."
  type        = string
  default     = "private-ranges-only"
}

variable "ssl_certificates" {
  description = "A object with a list of domains to auto-generate SSL certificates or a list of SSL Certificates self-links in the pattern `projects/<PROJECT-ID>/global/sslCertificates/<CERT-NAME>` to be used by Load Balancer."
  type = object({
    ssl_certificates_self_links       = list(string)
    generate_certificates_for_domains = list(string)
  })
  default = null
}
