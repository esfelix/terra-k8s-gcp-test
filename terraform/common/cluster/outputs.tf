# outputs.tf

# Output the GKE Cluster endpoint for access
output "cluster_endpoint" {
  description = "The endpoint of the GKE cluster for API access"
  value       = google_container_cluster.primary.endpoint
}
