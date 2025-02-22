provider "google" {
  credentials = file("terraform_credentails.json")
  project     = var.config.gcp_project_id
  region      = "us-central1"
  zone        = "us-central1-a"
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.18.1"
    }
  }
}
