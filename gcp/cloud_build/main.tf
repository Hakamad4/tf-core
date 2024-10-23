locals {
  triggers = { for trigger in var.triggers : trigger["name"] => trigger }
}

resource "google_project_service_identity" "identity" {

  provider = google-beta
  project  = var.project_id
  service  = "cloudbuild.googleapis.com"
}

resource "google_project_iam_member" "roles" {
  count   = length(var.roles)
  project = google_project_service_identity.identity.project
  role    = element(var.roles, count.index)
  member  = "serviceAccount:${google_project_service_identity.identity.email}"

  depends_on = [google_cloudbuild_trigger.this]
}


resource "google_cloudbuild_trigger" "this" {
  for_each = local.triggers

  provider        = google-beta
  project         = var.project_id
  name            = each.key
  disabled        = each.value["disabled"] == null ? false : each.value["disabled"]
  description     = each.value["description"] == null ? "Automatic trigger for external source on repository ${each.value["github_name"]}" : each.value["description"]
  filename        = each.value["filename"]
  substitutions   = each.value["substitutions"]
  ignored_files   = each.value["ignore_files"]
  included_files  = each.value["included_files"]
  service_account = each.value["service_account"] != null ? each.value["service_account"] : "projects/-/serviceAccounts/${google_project_service_identity.identity.email}"

  github {
    name  = each.value["github_name"]
    owner = each.value["github_owner"]

    dynamic "pull_request" {
      for_each = each.value["github_pull_request"] != null ? [each.value["github_pull_request"]] : []
      content {
        branch          = pull_request.value["branch"]
        comment_control = pull_request.value["comment_control"]
        invert_regex    = pull_request.value["invert_regex"]
      }
    }

    dynamic "push" {
      for_each = each.value["github_push"] != null ? [each.value["github_push"]] : []
      content {
        branch       = push.value["branch"]
        invert_regex = push.value["invert_regex"]
        tag          = push.value["tag"]
      }
    }
  }

  approval_config {
    approval_required = each.value["approval_required"] == null ? false : each.value["approval_required"]
  }

  depends_on = [google_project_service_identity.identity]
}

# resource "dummy" "dummy" {}