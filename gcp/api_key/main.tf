resource "random_id" "suffix" {
  count       = var.random_resource_name ? 1 : 0
  byte_length = 4
}

resource "google_apikeys_key" "key" {
  provider     = google-beta
  name         = var.random_resource_name ? "${var.name}-${random_id.suffix[0].hex}" : var.name
  display_name = var.display_name
  project      = var.project_id

  restrictions {

    dynamic "api_targets" {
      for_each = var.api_targets
      content {
        service = api_targets.value.service
        methods = api_targets.value.methods
      }
    }

    dynamic "server_key_restrictions" {
      for_each = var.allowed_ip == null ? [] : [1]
      content {
        allowed_ips = var.allowed_ip
      }
    }

    dynamic "android_key_restrictions" {
      for_each = var.android_allowed_applications == null ? [] : [1]
      content {
        dynamic "allowed_applications" {
          for_each = var.android_allowed_applications
          content {
            package_name     = allowed_applications.value.package_name
            sha1_fingerprint = allowed_applications.value.package_name.sha1_fingerprint
          }
        }
      }
    }

    dynamic "ios_key_restrictions" {
      for_each = var.ios_allowed_bundle_ids == null ? [] : [1]
      content {
        allowed_bundle_ids = var.ios_allowed_bundle_ids
      }
    }

    dynamic "browser_key_restrictions" {
      for_each = var.browser_allowed_restrictions == null ? [] : [1]
      content {
        allowed_referrers = var.browser_allowed_restrictions
      }
    }
  }
}
