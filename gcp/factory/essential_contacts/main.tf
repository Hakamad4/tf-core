/******************************************
  Essential Contact configuration
 *****************************************/

resource "google_essential_contacts_contact" "contact" {
  for_each = var.essential_contacts

  parent                              = "projects/${var.project_id}"
  email                               = each.key
  language_tag                        = var.language_tag
  notification_category_subscriptions = each.value
}
