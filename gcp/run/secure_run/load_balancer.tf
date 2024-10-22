locals {
  cloud_armor_id = var.create_cloud_armor_policies ? google_compute_security_policy.cloud_armor_security_policy[0].id : "projects/${var.project_id}/global/securityPolicies/${var.cloud_armor_policies_name}"
}

module "lb-http" {
  source = "../../lb_http/serverless_neg"

  project                         = var.project_id
  name                            = var.lb_name
  ssl                             = var.ssl_certificates != null && (length(var.ssl_certificates.generate_certificates_for_domains) > 0 || length(var.ssl_certificates.ssl_certificates_self_links) > 0) ? true : false
  managed_ssl_certificate_domains = var.ssl_certificates != null ? var.ssl_certificates.generate_certificates_for_domains : []
  ssl_certificates                = var.ssl_certificates != null ? var.ssl_certificates.ssl_certificates_self_links : []
  use_ssl_certificates            = var.ssl_certificates != null && length(var.ssl_certificates.generate_certificates_for_domains) == 0 ? true : false
  https_redirect                  = false
  ssl_policy                      = var.ssl_policy
  http_forward                    = var.http_forward

  backends = {
    default = {
      description = null
      groups = [
        {
          group = google_compute_region_network_endpoint_group.serverless_neg.id
        }
      ]
      enable_cdn              = false
      security_policy         = var.create_cloud_armor_policies || var.cloud_armor_policies_name != "" ? local.cloud_armor_id : ""
      custom_request_headers  = null
      custom_response_headers = null
      compression_mode        = null
      port_name               = "http"
      protocol                = "HTTP"

      iap_config = {
        enable               = false
        oauth2_client_id     = ""
        oauth2_client_secret = ""
      }
      log_config = {
        enable      = true
        sample_rate = 1
      }
    }
  }
  depends_on = [google_compute_security_policy.cloud_armor_security_policy]
}

resource "google_compute_region_network_endpoint_group" "serverless_neg" {
  provider              = google-beta
  name                  = var.serverless_neg == "" ? "${var.lb_name}-sn" : var.serverless_neg
  project               = var.project_id
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  cloud_run {
    service = var.service_name
  }
}

resource "google_compute_security_policy" "cloud_armor_security_policy" {
  count   = var.create_cloud_armor_policies ? 1 : 0
  project = var.project_id
  name    = "cloud-armor-waf-policy"

  dynamic "rule" {
    for_each = var.default_rules
    content {
      action      = rule.value.action
      priority    = rule.value.priority
      description = rule.value.description
      match {
        versioned_expr = rule.value.versioned_expr
        config {
          src_ip_ranges = rule.value.src_ip_ranges
        }
      }
    }
  }

  dynamic "rule" {
    for_each = var.owasp_rules
    content {
      action   = rule.value.action
      priority = rule.value.priority
      match {
        expr {
          expression = rule.value.expression
        }
      }
    }
  }
}
