terraform {
  required_version = ">= 1.3"

  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
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
