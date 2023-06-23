provider "google" {
  # credentials = file("iti-gcp-project-390712-ca270ab16e9d.json")
  project = var.project_id
  region  = var.region
}
terraform {
  backend "gcs" { #gcs provide automatic state locking
    bucket = "terraform-backend-anthos2"
    prefix = "terraform/state"
  }
}