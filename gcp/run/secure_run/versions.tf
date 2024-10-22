terraform {
  required_version = ">= 1.3"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.30.0, < 6"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 5.30.0, < 6"

    }
  }
}
