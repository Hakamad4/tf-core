output "secret_names" {
  description = "The name list of Secrets"
  value = concat(
    values({ for k, v in google_secret_manager_secret.secrets : k => v.name }),
  )
}

output "secret_versions" {
  description = "The name list of Secret Versions"
  value = concat(
    values({ for k, v in google_secret_manager_secret_version.secret-version : k => v.name }),
  )
}
