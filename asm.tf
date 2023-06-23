resource "null_resource" "install_asm" {
  provisioner "local-exec" {
    command = <<EOF
    gcloud services enable mesh.googleapis.com --project ${var.project_id}
    gcloud container fleet mesh enable --project ${var.project_id}
    gcloud container clusters get-credentials ${google_container_cluster.primary.name} --zone ${google_container_cluster.primary.location} --project ${var.project_id}
    gcloud container fleet memberships register gke-membership --gke-uri=https://container.googleapis.com/v1/projects/${var.project_id}/zones/${google_container_cluster.primary.location}/clusters/${google_container_cluster.primary.name} --enable-workload-identity --project ${var.project_id}
    gcloud container clusters update CLUSTER_NAME --project ${var.project_id} --zone ${google_container_cluster.primary.location} --update-labels mesh_id=proj-${var.project_id}
    gcloud container fleet mesh update --management automatic --memberships gke-membership --project ${var.project_id} --location global
    EOF
  }
  depends_on = [google_container_cluster.primary]
}


# sudo apt-get update && sudo apt-get --only-upgrade install google-cloud-sdk-app-engine-java google-cloud-sdk-datastore-emulator google-cloud-sdk-cloud-build-local google-cloud-sdk-skaffold google-cloud-sdk-local-extract google-cloud-sdk-kubectl-oidc google-cloud-sdk-terraform-tools google-cloud-sdk-nomos google-cloud-sdk-pubsub-emulator google-cloud-sdk-cloud-run-proxy google-cloud-sdk-app-engine-python-extras google-cloud-sdk-app-engine-grpc google-cloud-sdk-gke-gcloud-auth-plugin google-cloud-sdk-harbourbridge google-cloud-sdk-app-engine-python kubectl google-cloud-sdk-enterprise-certificate-proxy google-cloud-sdk-log-streaming google-cloud-sdk google-cloud-sdk-spanner-emulator google-cloud-sdk-minikube google-cloud-sdk-config-connector google-cloud-sdk-anthos-auth google-cloud-sdk-bigtable-emulator google-cloud-sdk-package-go-module google-cloud-sdk-cbt google-cloud-sdk-kpt google-cloud-sdk-firestore-emulator google-cloud-sdk-app-engine-go
# https://cloud.google.com/service-mesh/docs/deploy-bookinfo