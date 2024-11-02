# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0



# GKE cluster
data "google_container_engine_versions" "gke_version" {
  location       = var.region
  version_prefix = "1.30."
}

resource "google_container_cluster" "primary" {
  name     = "${var.project_id}-gke"
  location = "${var.region}-a"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = var.network_name
  subnetwork = var.subnet_name


  logging_service     = "none" # Disables Stackdriver logging
  monitoring_service  = "none" # Disables Stackdriver monitoring
  deletion_protection = false  # Not for production use

}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = google_container_cluster.primary.name
  depends_on = [google_container_cluster.primary]
  location   = google_container_cluster.primary.location
  cluster    = google_container_cluster.primary.name

  version    = data.google_container_engine_versions.gke_version.release_channel_latest_version["STABLE"]
  node_count = var.gke_num_nodes

  node_config {
    oauth_scopes = []


    labels = {
      env = var.project_id
    }

    # Adding preemptible = true in the node_config block makes the nodes cheaper but
    # with the trade-off of potentially being shut down by GCP at any time.
    # This is useful for testing environments but should be avoided for production workloads.
    preemptible  = true
    machine_type = var.gke_node_machine_type
    tags         = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}
