module "cluster" {
  source = "git::https://github.com/nimbolus/tf-k3s-cluster?ref=v0.1.2"

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
  cluster_instance_properties         = var.cluster_instance_properties
  cluster_k3s_version                 = var.cluster_k3s_version
}

resource "openstack_networking_secgroup_rule_v2" "http" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = var.rancher_ip_whitelist
  security_group_id = module.cluster.secgroup_id
}

resource "openstack_networking_secgroup_rule_v2" "https" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = var.rancher_ip_whitelist
  security_group_id = module.cluster.secgroup_id
}
