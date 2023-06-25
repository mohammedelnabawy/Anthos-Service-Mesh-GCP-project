# Managed Anthos Service Mesh Configuration Guide

This guide provides step-by-step instructions for configuring managed Anthos Service Mesh for each cluster in your mesh. Before proceeding, make sure you have the following prerequisites:

- A Cloud project
- A Cloud Billing account
- Obtained the required permissions to provision managed Anthos Service Mesh
- Enabled Workload Identity on your clusters
## Configure each cluster

Use the following steps to configure managed Anthos Service Mesh for each cluster in your mesh.

### Configure gcloud

Do the following steps even if you are using Cloud Shell.

1. Authenticate with the Google Cloud CLI:

    ```bash
    gcloud auth login --project PROJECT_ID
    ```

    Replace `PROJECT_ID` with your Cloud project ID.

2. Update the components:

    ```bash
    gcloud components update
    ```

3. Configure `kubectl` to point to the cluster.

   Note: Use `--region` instead of `--zone`, if the cluster is a regional cluster.

    ```bash
    gcloud container clusters get-credentials CLUSTER_NAME \
        --zone CLUSTER_LOCATION \
        --project PROJECT_ID
    ```

    Replace `CLUSTER_NAME` with the name of your cluster, `CLUSTER_LOCATION` with the zone or region of your cluster, and `PROJECT_ID` with your Cloud project ID.


   ### Register clusters to a fleet

1. Register a GKE cluster using Workload Identity to a fleet:

    ```bash
    gcloud container fleet memberships register MEMBERSHIP_NAME \
        --gke-uri=GKE_URI \
        --enable-workload-identity \
        --project FLEET_PROJECT_ID
    ```

2. Verify your cluster is registered:

    ```bash
    gcloud container fleet memberships list --project FLEET_PROJECT_ID
    ```

3. If your cluster's project differs from your fleet host project, you must allow Anthos Service Mesh service accounts in the fleet project to access the cluster project, and enable required APIs on the cluster project. You only need to do this once for each cluster project.


   Grant service accounts in the fleet project permission to access the cluster project:

    ```bash
    gcloud projects add-iam-policy-binding "PROJECT_ID" \
        --member "serviceAccount:service-FLEET_PROJECT_NUMBER@gcp-sa-servicemesh.iam.gserviceaccount.com" \
        --role roles/anthosservicemesh.serviceAgent
    ```

   You can get the project number for your fleet project by running the following command:

    ```bash
    FLEET_PROJECT_NUMBER=$(gcloud projects list --filter="FLEET_PROJECT_ID" --format="value(PROJECT_NUMBER)")
    ```

   Enable the Mesh API on the cluster's project:


# Apply the mesh_id label
 ```bash
gcloud container clusters update CLUSTER_NAME --project PROJECT_ID \
  --zone CLUSTER_LOCATION --update-labels mesh_id=proj-FLEET_PROJECT_NUMBER
 ```
where:

PROJECT_ID is the unique identifier of your cluster project.
CLUSTER_NAME is the name of your cluster.
CLUSTER_LOCATION is the compute zone or region for your cluster.
FLEET_PROJECT_NUMBER is the project number for your fleet host project.

    ```bash
    gcloud services enable mesh.googleapis.com \
        --project=PROJECT_ID



# Enable automatic management
 ```bash
 gcloud container fleet mesh update \
  --management automatic \
  --memberships MEMBERSHIP_NAME \
  --project FLEET_PROJECT_ID \
  --location MEMBERSHIP_LOCATION
``` 
where:

MEMBERSHIP_LOCATION is the location of your membership (either a region or global).


    ```

