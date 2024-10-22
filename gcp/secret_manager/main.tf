resource "google_project_service_identity" "secretmanager_identity" {
  count    = length(var.add_kms_permissions) > 0 || length(var.add_pubsub_permissions) > 0 ? 1 : 0
  provider = google-beta
  project  = var.project_id
  service  = "secretmanager.googleapis.com"
}

resource "google_kms_crypto_key_iam_member" "sm_sa_encrypter_decrypter" {
  count         = var.add_kms_permissions != null ? length(var.add_kms_permissions) : 0
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:${google_project_service_identity.secretmanager_identity[0].email}"
  crypto_key_id = var.add_kms_permissions[count.index]
}

resource "google_pubsub_topic_iam_member" "sm_sa_publisher" {
  project = var.project_id
  count   = var.add_pubsub_permissions != null ? length(var.add_pubsub_permissions) : 0
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:${google_project_service_identity.secretmanager_identity[0].email}"
  topic   = var.add_pubsub_permissions[count.index]
}

resource "google_secret_manager_secret" "secrets" {
  project   = var.project_id
  for_each  = { for secret in var.secrets : secret.name => secret }
  secret_id = each.value.name
  replication {
    dynamic "user_managed" {
      for_each = lookup(var.user_managed_replication, each.key, null) != null ? [1] : []
      content {
        dynamic "replicas" {
          for_each = lookup(var.user_managed_replication, each.key, [])
          content {
            location = replicas.value.location
            dynamic "customer_managed_encryption" {
              for_each = replicas.value.kms_key_name != null ? [replicas.value.kms_key_name] : []
              content {
                kms_key_name = customer_managed_encryption.value
              }
            }
          }
        }
      }
    }
    auto {}
  }
  labels = var.labels
  dynamic "topics" {
    for_each = lookup(var.topics, each.key, [])
    content {
      name = topics.value.name
    }
  }
  dynamic "rotation" {
    for_each = (lookup(each.value, "next_rotation_time", null) != null || lookup(each.value, "rotation_period", null) != null) ? [1] : []
    content {
      next_rotation_time = lookup(each.value, "next_rotation_time", null)
      rotation_period    = lookup(each.value, "rotation_period", null)
    }
  }
  depends_on = [
    google_kms_crypto_key_iam_member.sm_sa_encrypter_decrypter,
    google_pubsub_topic_iam_member.sm_sa_publisher
  ]
}

resource "google_secret_manager_secret_version" "secret-version" {
  for_each    = { for secret in var.secrets : secret.name => secret }
  secret      = google_secret_manager_secret.secrets[each.value.name].id
  secret_data = each.value.secret_data
}