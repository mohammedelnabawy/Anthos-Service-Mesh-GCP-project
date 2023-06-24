#!/bin/bash
gcloud services enable mesh.googleapis.com --project=iti-gcp-project-390712
gcloud container fleet mesh enable --project iti-gcp-project-390712
gcloud container clusters get-credentials iti-gcp-project-390712-gke --zone us-central1-f --project iti-gcp-project-390712
gcloud container clusters update iti-gcp-project-390712-gke --project iti-gcp-project-390712 --zone us-central1-f --update-labels mesh_id=proj-iti-gcp-project-390712
gcloud container fleet mesh update --management automatic --memberships gke-membership --project iti-gcp-project-390712 --location global