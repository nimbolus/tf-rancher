output "rancher_token" {
  value     = rancher2_bootstrap.admin.token
  sensitive = true
}

output "rancher_admin_password" {
  value     = random_password.rancher_admin_password.result
  sensitive = true
}

output "rancher_server_port_id" {
  value = openstack_compute_instance_v2.rancher_server.network.0.port
}

output "rancher_server_ip" {
  value = openstack_compute_instance_v2.rancher_server.network.0.fixed_ip_v4
}
