#!/bin/bash
gcloud services enable mesh.googleapis.com --project=iti-gcp-project-390712
gcloud container fleet mesh enable --project iti-gcp-project-390712
gcloud container clusters get-credentials iti-gcp-project-390712-gke --zone us-central1-f --project iti-gcp-project-390712
gcloud container clusters update iti-gcp-project-390712-gke --project iti-gcp-project-390712 --zone us-central1-f --update-labels mesh_id=proj-iti-gcp-project-390712
gcloud container fleet mesh update --management automatic --memberships gke-membership --project iti-gcp-project-390712 --location global
sleep 180
git clone https://github.com/GoogleCloudPlatform/anthos-service-mesh-packages.git
kubectl create namespace gateway-namespace
kubectl label namespace gateway-namespace istio-injection=enabled istio.io/rev-
kubectl apply -n gateway-namespace -f ./anthos-service-mesh-packages/samples/gateways/istio-ingressgateway
kubectl apply -f ./anthos-service-mesh-packages/samples/online-boutique/kubernetes-manifests/namespaces
for ns in ad cart checkout currency email frontend loadgenerator payment product-catalog recommendation shipping; do
  kubectl label namespace $ns istio-injection=enabled istio.io/rev-
done;
kubectl apply -f ./anthos-service-mesh-packages/samples/online-boutique/kubernetes-manifests/deployments
sleep 60
kubectl apply -f ./anthos-service-mesh-packages/samples/online-boutique/kubernetes-manifests/services
kubectl apply -f ./anthos-service-mesh-packages/samples/online-boutique/istio-manifests/allow-egress-googleapis.yaml