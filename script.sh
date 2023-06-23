gcloud config set project PROJECT_ID
gcloud services enable compute.googleapis.com &
gcloud services enable container.googleapis.com &
gcloud container clusters get-credentials CLUSTER_NAME --project=PROJECT_ID --zone=CLUSTER_LOCATION
kubectl config set-context CLUSTER_NAME