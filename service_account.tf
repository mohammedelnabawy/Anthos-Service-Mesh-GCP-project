resource "google_service_account" "service_account" {
  account_id   = "gke_Service_Account@iti-gcp-project-390712.iam.gserviceaccount.com"
  display_name = "gke_Service_Account"
}

resource "google_project_iam_member" "firestore_owner_binding" {
  project = var.project_id
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.service_account.email}"
}