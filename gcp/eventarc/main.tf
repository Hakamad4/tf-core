resource "google_eventarc_trigger" "main" {
  project         = var.project_id
  name            = var.name
  location        = var.region
  service_account = var.service_account

  dynamic "matching_criteria" {
    for_each = var.matching_criteria
    content {
      attribute = matching_criteria.value["attribute"]
      value     = matching_criteria.value["value"]
      operator  = matching_criteria.value["operator"]
    }
  }

  dynamic "transport" {
    for_each = var.transport != null ? [1] : toset([])
    content {
      pubsub {
        topic = var.transport.topic
      }
    }

  }

  destination {
    workflow = var.workflow_id
  }

  labels = var.labels
}
