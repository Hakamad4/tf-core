locals {
  redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
  address                = var.create_address ? join("", google_compute_global_address.default.*.address) : var.address
  url_map                = var.create_url_map ? join("", google_compute_url_map.default.*.self_link) : var.url_map
  create_http_forward    = var.http_forward || var.https_redirect
  url_map_name           = var.default_url_map_name == null ? "${var.name}-https" : var.default_url_map_name
  url_map_redirect_name  = var.default_url_map_redirect_name == null ? "${var.name}-https-redirect" : var.default_url_map_redirect_name
}

resource "google_compute_global_forwarding_rule" "http" {
  count = local.create_http_forward ? 1 : 0

  provider   = google-beta
  project    = var.project_id
  name       = var.name
  target     = google_compute_target_http_proxy.default[0].self_link
  ip_address = local.address
  port_range = "80"
  labels     = var.labels
}

resource "google_compute_global_forwarding_rule" "https" {
  count = var.ssl ? 1 : 0

  provider   = google-beta
  project    = var.project_id
  name       = "${var.name}-https"
  target     = google_compute_target_https_proxy.default[0].self_link
  ip_address = local.address
  port_range = "443"
  labels     = var.labels
}

resource "google_compute_global_address" "default" {
  count = var.create_address ? 1 : 0

  provider   = google-beta
  project    = var.project_id
  name       = "${var.name}-address"
  ip_version = var.ip_version
  labels     = var.labels
}

resource "google_compute_target_http_proxy" "default" {
  count = local.create_http_forward ? 1 : 0

  project = var.project_id
  name    = "${var.name}-http-proxy"
  url_map = var.https_redirect == false ? local.url_map : join("", google_compute_url_map.https_redirect.*.self_link)
}

resource "google_compute_target_https_proxy" "default" {
  count = var.ssl ? 1 : 0

  project          = var.project_id
  name             = "${var.name}-https-proxy"
  url_map          = local.url_map
  ssl_certificates = compact(concat(var.ssl_certificates, google_compute_ssl_certificate.default.*.self_link, google_compute_managed_ssl_certificate.default.*.self_link, ), )
  ssl_policy       = var.ssl_policy
  quic_override    = var.quic ? "ENABLE" : null
}

resource "google_compute_ssl_certificate" "default" {
  count = var.ssl && length(var.managed_ssl_certificate_domains) == 0 && ! var.use_ssl_certificates ? 1 : 0

  project     = var.project_id
  name_prefix = "${var.name}-certificate-"
  private_key = var.private_key
  certificate = var.certificate

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_managed_ssl_certificate" "default" {
  count = var.ssl && length(var.managed_ssl_certificate_domains) > 0 && ! var.use_ssl_certificates ? 1 : 0

  provider = google-beta
  project  = var.project_id
  name     = "${var.name}-cert"

  managed {
    domains = var.managed_ssl_certificate_domains
  }
}

resource "google_compute_url_map" "default" {
  count = var.create_url_map ? 1 : 0

  project         = var.project_id
  name            = local.url_map_name
  default_service = google_compute_backend_bucket.default_backend_bucket.self_link
}

resource "google_compute_url_map" "https_redirect" {
  count = var.https_redirect ? 1 : 0

  project = var.project_id
  name    = local.url_map_redirect_name

  default_url_redirect {
    https_redirect         = true
    redirect_response_code = local.redirect_response_code
    strip_query            = false
  }
}

resource "google_compute_backend_bucket" "default_backend_bucket" {
  provider                = google-beta
  project                 = var.project_id
  name                    = random_id.be-bucket.hex
  description             = var.backend_description
  custom_response_headers = var.backend_customer_response_headers
  bucket_name             = var.bucket_name
  enable_cdn              = var.cdn
}

resource "random_id" "be-bucket" {
  prefix      = "${var.project_id}-lb-be-"
  byte_length = 2
}
