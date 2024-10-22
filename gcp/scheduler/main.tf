resource "google_cloud_scheduler_job" "job" {
  project          = var.project_id
  name             = var.name
  description      = var.description
  region           = var.region
  schedule         = var.schedule
  paused           = var.paused
  time_zone        = var.time_zone
  attempt_deadline = var.attempt_deadline

  dynamic "http_target" {
    for_each = var.http_target != null ? [1] : []
    content {
      uri         = var.http_target.uri
      http_method = var.http_target.http_method
      headers     = var.http_target.headers
      body        = var.http_target.body

      dynamic "oauth_token" {
        for_each = var.http_target.oauth_token_service_account_email != null ? [var.http_target] : []
        content {
          service_account_email = oauth_token.value["oauth_token_service_account_email"]
          scope                 = oauth_token.value["oauth_token_scope"]
        }
      }

      dynamic "oidc_token" {
        for_each = var.http_target.oidc_token_service_account_email != null ? [var.http_target] : []
        content {
          service_account_email = oidc_token.value["oidc_token_service_account_email"]
          audience              = oidc_token.value["oidc_token_audience"]
        }
      }
    }
  }

  dynamic "pubsub_target" {
    for_each = var.pubsub_target != null ? [1] : []
    content {
      topic_name = var.pubsub_target.topic_name
      data       = base64encode(var.pubsub_target.data)
      attributes = var.pubsub_target.attributes
    }
  }

  dynamic "retry_config" {
    for_each = var.retry_config != null ? [1] : []
    content {
      retry_count          = var.retry_config.retry_count
      max_backoff_duration = var.retry_config.max_backoff_duration
      max_doublings        = var.retry_config.max_doublings
      max_retry_duration   = var.retry_config.max_retry_duration
      min_backoff_duration = var.retry_config.min_backoff_duration
    }
  }
}