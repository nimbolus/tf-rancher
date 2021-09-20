module "cluster" {
  source = "../cluster"

  cluster_name                        = var.rancher_name
  cluster_availability_zone           = var.cluster_availability_zone
  cluster_size                        = var.cluster_size
  cluster_servers                     = var.cluster_size
  cluster_image_name                  = var.cluster_image_name
  cluster_flavor_name                 = var.cluster_flavor_name
  cluster_volume_type                 = var.cluster_volume_type
  cluster_volume_size                 = var.cluster_volume_size
  cluster_key_pair                    = var.cluster_key_pair
  cluster_servers_server_group_policy = var.cluster_server_group_policy
  cluster_floating_ip_pool            = var.cluster_floating_ip_pool
  cluster_server1_floating_ip         = var.cluster_server1_floating_ip
  cluster_servers_floating_ip         = var.cluster_servers_floating_ip
  cluster_network_id                  = var.cluster_network_id
  cluster_subnet_id                   = var.cluster_subnet_id
}
