resource "null_resource" "install_asm" {
  provisioner "local-exec" {
    command = <<EOF
    gcloud container fleet mesh enable --project ${var.project_id}
    gcloud container fleet memberships register ${google_container_cluster.primary.name}-membership --gke-cluster=${google_container_cluster.primary.location}/${google_container_cluster.primary.name} --enable-workload-identity --project ${var.project_id}
    gcloud container fleet mesh update  --management automatic --memberships ${google_container_cluster.primary.name}-membership --project ${var.project_id}
    gcloud container fleet mesh describe --project ${var.project_id}
    EOF
  }
  depends_on = [google_container_cluster.primary]
}
