
output "composer_env_name" {
  value = google_composer_environment.composer_env.name
}

output "composer_env_id" {
  value = google_composer_environment.composer_env.id
}

output "gke_cluster" {
  value = google_composer_environment.composer_env.config.0.gke_cluster
}

output "gcs_bucket" {
  value = google_composer_environment.composer_env.config.0.dag_gcs_prefix
}

output "airflow_uri" {
  value = google_composer_environment.composer_env.config.0.airflow_uri
}
