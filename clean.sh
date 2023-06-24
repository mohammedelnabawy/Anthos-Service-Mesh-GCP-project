#!/bin/bash
kubectl delete -f ./anthos-service-mesh-packages/samples/online-boutique/kubernetes-manifests/namespaces
kubectl delete -f ./anthos-service-mesh-packages/samples/online-boutique/istio-manifests/allow-egress-googleapis.yaml