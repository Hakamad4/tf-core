/*****************************************
  Organization info retrieval
 *****************************************/
module "gsuite_group" {
  source = "./gsuite_group"

  domain = var.domain
  name   = var.group_name
  org_id = var.org_id
}

module "project-factory" {
  source = "./core_project_factory"

  group_email                        = module.gsuite_group.email
  group_role                         = var.group_role
  lien                               = var.lien
  manage_group                       = var.group_name != "" ? true : false
  random_project_id                  = var.random_project_id
  random_project_id_length           = var.random_project_id_length
  org_id                             = var.org_id
  name                               = var.name
  project_id                         = var.project_id
  shared_vpc                         = var.svpc_host_project_id
  enable_shared_vpc_service_project  = var.svpc_host_project_id != ""
  enable_shared_vpc_host_project     = var.enable_shared_vpc_host_project
  grant_network_role                 = var.grant_network_role
  billing_account                    = var.billing_account
  folder_id                          = var.folder_id
  create_project_sa                  = var.create_project_sa
  project_sa_name                    = var.project_sa_name
  sa_role                            = var.sa_role
  activate_apis                      = var.activate_apis
  activate_api_identities            = var.activate_api_identities
  usage_bucket_name                  = var.usage_bucket_name
  usage_bucket_prefix                = var.usage_bucket_prefix
  shared_vpc_subnets                 = var.shared_vpc_subnets
  labels                             = var.labels
  bucket_project                     = var.bucket_project
  bucket_name                        = var.bucket_name
  bucket_location                    = var.bucket_location
  bucket_versioning                  = var.bucket_versioning
  bucket_labels                      = var.bucket_labels
  bucket_force_destroy               = var.bucket_force_destroy
  bucket_ula                         = var.bucket_ula
  bucket_pap                         = var.bucket_pap
  auto_create_network                = var.auto_create_network
  disable_services_on_destroy        = var.disable_services_on_destroy
  default_service_account            = var.default_service_account
  disable_dependent_services         = var.disable_dependent_services
  vpc_service_control_attach_enabled = var.vpc_service_control_attach_enabled
  vpc_service_control_perimeter_name = var.vpc_service_control_perimeter_name
  vpc_service_control_sleep_duration = var.vpc_service_control_sleep_duration
  default_network_tier               = var.default_network_tier
}

/******************************************
  Setting API service accounts for shared VPC
 *****************************************/
module "shared_vpc_access" {
  source                             = "./shared_vpc_access"
  enable_shared_vpc_service_project  = var.svpc_host_project_id != "" ? true : false
  host_project_id                    = var.svpc_host_project_id
  service_project_id                 = module.project-factory.project_id
  active_apis                        = module.project-factory.enabled_apis
  shared_vpc_subnets                 = var.shared_vpc_subnets
  service_project_number             = module.project-factory.project_number
  lookup_project_numbers             = false
  grant_services_security_admin_role = var.grant_services_security_admin_role
  grant_network_role                 = var.grant_network_role
}

/******************************************
  Billing budget to create if amount is set
 *****************************************/
module "budget" {
  source        = "./budget"
  create_budget = var.budget_amount != null

  projects                         = [module.project-factory.project_id]
  billing_account                  = var.billing_account
  amount                           = var.budget_amount
  alert_spent_percents             = var.budget_alert_spent_percents
  alert_spend_basis                = var.budget_alert_spend_basis
  alert_pubsub_topic               = var.budget_alert_pubsub_topic
  monitoring_notification_channels = var.budget_monitoring_notification_channels
  display_name                     = var.budget_display_name != null ? var.budget_display_name : null
  labels                           = var.budget_labels
  calendar_period                  = var.budget_calendar_period
  custom_period_start_date         = var.budget_custom_period_start_date
  custom_period_end_date           = var.budget_custom_period_end_date
}

/******************************************
  Quota to override if metrics are set
 *****************************************/
module "quotas" {
  source = "./quota_manager"

  project_id      = module.project-factory.project_id
  consumer_quotas = var.consumer_quotas
}

/******************************************
  Essential Contacts to create if set
 *****************************************/
module "essential_contacts" {
  source = "./essential_contacts"

  project_id         = module.project-factory.project_id
  essential_contacts = var.essential_contacts
  language_tag       = var.language_tag
}
