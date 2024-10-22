locals {
  consumer_quotas = { for index, quota in var.consumer_quotas : "${quota.service}-${quota.metric}" => quota }
}

resource "google_service_usage_consumer_quota_override" "override" {
  provider = google-beta
  for_each = local.consumer_quotas

  project        = var.project_id
  service        = each.value.service
  metric         = each.value.metric
  limit          = each.value.limit
  dimensions     = each.value.dimensions
  override_value = each.value.value
  force          = true
}
