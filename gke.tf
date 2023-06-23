# GKE cluster
resource "google_container_cluster" "primary" {
  name     = "${var.project_id}-gke"
  project  = var.project_id
  location = "${var.region}-f"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${var.project_id}-gke --project=${var.project_id} --zone=${var.region}-f & kubectl config set-context ${var.project_id}-gke"

  }
}


# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = google_container_cluster.primary.name
  location   = "${var.region}-f"
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_num_nodes

  node_config {
    machine_type = "e2-medium"
    service_account = google_service_account.service_account.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }

    # preemptible  = true
    machine_type = "n1-standard-1"
    tags         = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}
# Output the cluster information
output "cluster_info" {
  value = google_container_cluster.primary
  sensitive = true
}
