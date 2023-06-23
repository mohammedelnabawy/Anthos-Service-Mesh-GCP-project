resource "google_service_account" "service_account" {
  account_id   = "gke-sa"
  display_name = "gke-service-account"
}

resource "google_project_iam_member" "firestore_owner_binding" {
  project = var.project_id
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.service_account.email}"
}