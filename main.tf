data "openstack_images_image_v2" "rancher_server" {
  name        = var.rancher_server_image
  most_recent = true
}

data "openstack_compute_flavor_v2" "rancher_server" {
  name = var.rancher_server_flavor
}

resource "openstack_blockstorage_volume_v3" "rancher_data" {
  name              = "${var.rancher_server_name}-data"
  availability_zone = var.availability_zone
  size              = 10
  volume_type       = var.rancher_volume_type
}

resource "openstack_compute_instance_v2" "rancher_server" {
  name      = var.rancher_server_name
  image_id  = data.openstack_images_image_v2.rancher_server.id
  flavor_id = data.openstack_compute_flavor_v2.rancher_server.id
  key_pair  = var.rancher_server_key_pair
  metadata  = var.rancher_server_properties

  security_groups = [
    openstack_networking_secgroup_v2.rancher.name,
  ]

  availability_zone = var.availability_zone
  config_drive      = true
  user_data = templatefile("${path.module}/cloud-configs/centos.yml", {
    docker_compose_file = base64encode(templatefile("${path.module}/files/docker-compose.yml", {
      rancher_image   = var.rancher_image
      rancher_version = var.rancher_version
    }))
    hostname      = var.rancher_server_fqdn
    post_commands = var.rancher_server_post_commands
  })

  network {
    uuid        = var.network_id
    fixed_ip_v4 = var.rancher_server_ip_v4
  }
}

resource "openstack_compute_volume_attach_v2" "rancher_data" {
  instance_id = openstack_compute_instance_v2.rancher_server.id
  volume_id   = openstack_blockstorage_volume_v3.rancher_data.id
  device      = "/dev/vdb"
}
