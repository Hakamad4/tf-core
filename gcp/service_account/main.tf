locals {
  account_billing       = var.grant_billing_role && var.billing_account_id != ""
  org_billing           = var.grant_billing_role && var.billing_account_id == "" && var.org_id != ""
  prefix                = var.prefix != "" ? "${var.prefix}-" : ""
  xpn                   = var.grant_xpn_roles && var.org_id != ""
  service_accounts_list = [for account in google_service_account.service_accounts : account]
  emails_list           = [for account in local.service_accounts_list : account.email]
  iam_emails_list       = [for email in local.emails_list : "serviceAccount:${email}"]
  names                 = toset(var.names)
  name_role_pairs       = setproduct(local.names, toset(var.project_roles))
  project_roles_map_data = zipmap(
    [for pair in local.name_role_pairs : "${pair[0]}-${pair[1]}"],
    [for pair in local.name_role_pairs : {
      name = pair[0]
      role = pair[1]
    }]
  )
}

resource "google_service_account" "service_accounts" {
  provider = google-beta

  project      = var.project_id
  for_each     = local.names
  account_id   = "${local.prefix}${lower(each.value)}"
  display_name = var.display_name
  description  = index(var.names, each.value) >= length(var.descriptions) ? var.description : element(var.descriptions, index(var.names, each.value))
}

resource "google_project_iam_member" "project_roles" {
  provider = google-beta

  for_each = local.project_roles_map_data

  project = element(
    split(
      "=>",
      each.value.role
    ),
    0,
  )

  role = element(
    split(
      "=>",
      each.value.role
    ),
    1,
  )

  member = "serviceAccount:${google_service_account.service_accounts[each.value.name].email}"
}

resource "google_organization_iam_member" "billing_user" {
  for_each = local.org_billing ? local.names : toset([])
  org_id   = var.org_id
  role     = "roles/billing.user"
  member   = "serviceAccount:${google_service_account.service_accounts[each.value].email}"
}

resource "google_billing_account_iam_member" "billing_user" {
  for_each           = local.account_billing ? local.names : toset([])
  billing_account_id = var.billing_account_id
  role               = "roles/billing.user"
  member             = "serviceAccount:${google_service_account.service_accounts[each.value].email}"
}

resource "google_organization_iam_member" "xpn_admin" {
  for_each = local.xpn ? local.names : toset([])
  org_id   = var.org_id
  role     = "roles/compute.xpnAdmin"
  member   = "serviceAccount:${google_service_account.service_accounts[each.value].email}"
}

resource "google_organization_iam_member" "organization_viewer" {
  for_each = local.xpn ? local.names : toset([])
  org_id   = var.org_id
  role     = "roles/resourcemanager.organizationViewer"
  member   = "serviceAccount:${google_service_account.service_accounts[each.value].email}"
}

resource "google_service_account_key" "keys" {
  provider = google-beta

  for_each           = var.generate_keys ? local.names : toset([])
  service_account_id = google_service_account.service_accounts[each.value].email
}

module "secret-manager-export" {
  source = "../secret_manager"

  for_each   = var.generate_keys && var.export_key_to_sm ? local.names : toset([])
  project_id = var.project_id
  secrets = [
    {
      name                  = format("sa_key_%s", each.value)
      automatic_replication = false
      secret_data           = google_service_account_key.keys[each.value].private_key
    },
  ]

  labels = var.labels
}
