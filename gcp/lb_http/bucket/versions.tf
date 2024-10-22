terraform {
  required_version = ">= 1.3"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.30.0, < 6"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 2.1"
    }
  }
}
