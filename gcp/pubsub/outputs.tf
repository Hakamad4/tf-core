output "topic" {
  description = "The name of the Pub/Sub topic"
  value       = length(google_pubsub_topic.topic) > 0 ? google_pubsub_topic.topic[0].name : ""
}

output "topic_labels" {
  description = "Labels assigned to the Pub/Sub topic"
  value       = length(google_pubsub_topic.topic) > 0 ? google_pubsub_topic.topic[0].labels : {}
}

output "id" {
  description = "The ID of the Pub/Sub topic"
  value       = length(google_pubsub_topic.topic) > 0 ? google_pubsub_topic.topic[0].id : ""
}

output "uri" {
  description = "The URI of the Pub/Sub topic"
  value       = length(google_pubsub_topic.topic) > 0 ? "pubsub.googleapis.com/${google_pubsub_topic.topic[0].id}" : ""
}

output "subscription_names" {
  description = "The name list of Pub/Sub subscriptions"
  value = concat(
    values({ for k, v in google_pubsub_subscription.push_subscriptions : k => v.name }),
    values({ for k, v in google_pubsub_subscription.pull_subscriptions : k => v.name }),
    values({ for k, v in google_pubsub_subscription.bigquery_subscriptions : k => v.name }),
    values({ for k, v in google_pubsub_subscription.cloud_storage_subscriptions : k => v.name }),
  )
}

output "subscription_paths" {
  description = "The path list of Pub/Sub subscriptions"
  value = concat(
    values({ for k, v in google_pubsub_subscription.push_subscriptions : k => v.id }),
    values({ for k, v in google_pubsub_subscription.pull_subscriptions : k => v.id }),
    values({ for k, v in google_pubsub_subscription.bigquery_subscriptions : k => v.name }),
    values({ for k, v in google_pubsub_subscription.cloud_storage_subscriptions : k => v.name }),
  )
}
