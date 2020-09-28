output "ssh_private_key" {
  value = openstack_compute_keypair_v2.rancher_server.private_key
}

output "ssh_public_key" {
  value = openstack_compute_keypair_v2.rancher_server.public_key
}
