output "transport" {
  value = var.transport != null ? google_eventarc_trigger.main.transport[0].pubsub : null
}