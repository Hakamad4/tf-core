resource "random_password" "password" {
  length           = var.password_length
  special          = var.special_char
  lower            = var.lower
  upper            = var.upper
  min_lower        = var.min_lower
  min_numeric      = var.min_numeric
  min_special      = var.min_special
  min_upper        = var.min_upper
  numeric          = var.numeric
  override_special = var.override_special
}

module "secret_manager_save_password" {
  source     = "../secret_manager"
  count      = var.save && var.secret_name != null ? 1 : 0
  project_id = var.project_id
  secrets = [
    {
      secret_data           = random_password.password.result
      name                  = var.secret_name
      automatic_replication = var.automatic_replication
    }
  ]
  user_managed_replication = var.user_managed_replication
  topics                   = var.topics
  labels                   = var.labels
  add_kms_permissions      = var.add_kms_permissions
  add_pubsub_permissions   = var.add_pubsub_permissions
  depends_on               = [random_password.password]
}