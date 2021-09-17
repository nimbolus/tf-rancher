output "rancher_server_instance_id" {
  value = openstack_compute_instance_v2.rancher_server.id
}

output "rancher_server_port_id" {
  value = openstack_compute_instance_v2.rancher_server.network.0.port
}

output "rancher_server_ip" {
  value = openstack_compute_instance_v2.rancher_server.network.0.fixed_ip_v4
}
