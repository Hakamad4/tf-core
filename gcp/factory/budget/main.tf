locals {
  project_name     = length(var.projects) == 0 ? "All Projects" : var.projects[0]
  display_name     = var.display_name == null ? "Budget For ${local.project_name}" : var.display_name
  all_updates_rule = var.alert_pubsub_topic == null && length(var.monitoring_notification_channels) == 0 ? [] : ["1"]
  custom_period    = var.calendar_period == "CUSTOM" ? [1] : []
  start_date       = length(local.custom_period) != 0 ? split("-", var.custom_period_start_date) : null
  end_date         = length(local.custom_period) != 0 ? split("-", var.custom_period_end_date) : null

  projects = length(var.projects) == 0 ? null : [
    for project in data.google_project.project :
    "projects/${project.number}"
  ]
  services = var.services == null ? null : [
    for id in var.services :
    "services/${id}"
  ]
}

data "google_project" "project" {
  depends_on = [var.projects]
  count      = length(var.projects)
  project_id = element(var.projects, count.index)
}

resource "google_billing_budget" "budget" {
  count = var.create_budget ? 1 : 0

  billing_account = var.billing_account
  display_name    = local.display_name

  budget_filter {
    projects               = local.projects
    credit_types_treatment = var.credit_types_treatment
    services               = local.services
    labels                 = var.labels
    calendar_period        = length(local.custom_period) == 0 ? var.calendar_period : null

    dynamic "custom_period" {
      for_each = local.custom_period
      content {
        start_date {
          day   = local.start_date[0]
          month = local.start_date[1]
          year  = local.start_date[2]
        }
        end_date {
          day   = local.end_date[0]
          month = local.end_date[1]
          year  = local.end_date[2]
        }
      }
    }
  }

  amount {
    specified_amount {
      units = tostring(var.amount)
    }
  }

  dynamic "threshold_rules" {
    for_each = var.alert_spent_percents
    content {
      threshold_percent = threshold_rules.value
      spend_basis       = var.alert_spend_basis
    }
  }

  dynamic "all_updates_rule" {
    for_each = local.all_updates_rule
    content {
      pubsub_topic                     = var.alert_pubsub_topic
      monitoring_notification_channels = var.monitoring_notification_channels
    }
  }
}
