
module "cluster" {
  source                = "./common/cluster" # Specify the path to the cluster module
  project_id            = var.project_id     # Pass root-level variables as inputs
  region                = var.region
  network_name          = module.network.vpc_name # Passing output from network module
  subnet_name           = module.network.subnet_name
  gke_num_nodes         = 1
  gke_node_machine_type = "e2-micro"
}

module "network" {
  source     = "./common/network" # Specify the path to the network module
  project_id = var.project_id     # Pass root-level variables as inputs
  region     = var.region
}
