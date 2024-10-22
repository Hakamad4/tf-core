terraform {
  required_version = ">= 1.3"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.30.0, < 6"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 5.30.0, < 6"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 2.1"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 2.2"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.5"
    }
  }
}
