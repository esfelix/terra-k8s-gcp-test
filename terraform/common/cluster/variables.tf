# A variables.tf file is used to define the variables type and optionally set a default value

variable "gke_username" {
  default     = ""
  description = "gke username"
}

variable "gke_password" {
  default     = ""
  description = "gke password"
}

variable "gke_num_nodes" {
  default     = 2
  description = "number of gke nodes"
}

variable "gke_node_machine_type" {
  default     = "n1-standard-1"
  description = "The machine type for the GKE nodes"
}

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The region for the cluster"
  type        = string
}

variable "network_name" {
  description = "The name of the VPC network to use"
  type        = string
}

variable "subnet_name" {

  description = "The name of the subnet to use"
  type        = string

}
