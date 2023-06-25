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
