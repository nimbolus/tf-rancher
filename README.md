# terraform module - rancher

Sets up a Rancher cluster on top of OpenStack.

For an overview of the options, checkout [variables.tf](./variables.tf)

## Example

```terraform
resource "openstack_compute_keypair_v2" "rancher_cluster" {
  name = "rancher-cluster"
}

module "rancher" {
  source = "git::https://github.com/nimbolus/tf-rancher.git?ref=rancher-v2.6"

  cluster_availability_zone   = "nova"
  cluster_image_name          = "ubuntu-20.04"
  cluster_key_pair            = openstack_compute_keypair_v2.rancher_cluster.name
  cluster_volume_type         = "ssd"
  cluster_server_group_policy = "anti-affinity"
  cluster_network_id          = data.openstack_networking_network_v2.rancher.id
  cluster_subnet_id           = data.openstack_networking_subnet_v2.rancher.id
  rancher_hostname            = "rancher.example.com"
}

output "rancher_cluster_kubeconfig" {
  value     = module.rancher.kubeconfig
  sensitive = true
}
```
