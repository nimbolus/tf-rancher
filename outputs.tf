output "ssh_private_key" {
  value = openstack_compute_keypair_v2.rancher_server.private_key
}

output "ssh_public_key" {
  value = openstack_compute_keypair_v2.rancher_server.public_key
}

output "rancher_token" {
  value     = rancher2_bootstrap.admin.token
  sensitive = true
}

output "rancher_admin_password" {
  value     = random_password.rancher_admin_password.result
  sensitive = true
}
