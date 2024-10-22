output "keyring" {
  description = "Self link of the keyring."
  value       = google_kms_key_ring.key_ring.id

  depends_on = [
    google_kms_crypto_key_iam_binding.owners,
    google_kms_crypto_key_iam_binding.decrypters,
    google_kms_crypto_key_iam_binding.encrypters,
  ]
}

output "keyring_resource" {
  description = "Keyring resource."
  value       = google_kms_key_ring.key_ring

  depends_on = [
    google_kms_crypto_key_iam_binding.owners,
    google_kms_crypto_key_iam_binding.decrypters,
    google_kms_crypto_key_iam_binding.encrypters,
  ]
}

output "keys" {
  description = "Map of key name => key self link."
  value       = local.keys_by_name

  depends_on = [
    google_kms_crypto_key_iam_binding.owners,
    google_kms_crypto_key_iam_binding.decrypters,
    google_kms_crypto_key_iam_binding.encrypters,
  ]
}

output "keyring_name" {
  description = "Name of the keyring."
  value       = google_kms_key_ring.key_ring.name

  depends_on = [
    google_kms_crypto_key_iam_binding.owners,
    google_kms_crypto_key_iam_binding.decrypters,
    google_kms_crypto_key_iam_binding.encrypters,
  ]
}
