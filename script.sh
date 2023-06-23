gcloud config set project PROJECT_ID
gcloud services enable compute.googleapis.com &
gcloud services enable container.googleapis.com &
gcloud components install gke-gcloud-auth-plugin
gcloud container clusters get-credentials CLUSTER_NAME --project=PROJECT_ID --zone=CLUSTER_LOCATION
kubectl config set-context CLUSTER_NAME
curl https://storage.googleapis.com/csm-artifacts/asm/install_asm_1.10 > install_asm
chmod +x install_asm
