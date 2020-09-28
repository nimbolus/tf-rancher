data "openstack_images_image_v2" "rancher_server" {
  name        = var.rancher_server_image
  most_recent = true
}

data "openstack_compute_flavor_v2" "rancher_server" {
  name = var.rancher_server_flavor
}

data "openstack_networking_network_v2" "network" {
  name = var.network_name
}

resource "openstack_compute_keypair_v2" "rancher_server" {
  name = "rancher-server"
}

resource "openstack_blockstorage_volume_v3" "rancher_data" {
  name              = "rancher-server-data"
  availability_zone = var.availability_zone
  size              = 10
  volume_type       = var.rancher_volume_type
}

resource "openstack_compute_instance_v2" "rancher_server" {
  name      = "rancher-server"
  image_id  = data.openstack_images_image_v2.rancher_server.id
  flavor_id = data.openstack_compute_flavor_v2.rancher_server.id
  key_pair  = openstack_compute_keypair_v2.rancher_server.name

  security_groups = [
    openstack_networking_secgroup_v2.rancher.name,
  ]

  availability_zone = var.availability_zone
  config_drive      = true
  user_data = templatefile("${path.module}/cloud-configs/centos.yml", {
    docker_compose_file = base64encode(templatefile("${path.module}/files/docker-compose.yml", {
      rancher_version = var.rancher_version
    }))
    backup_docker_compose_file = filebase64("${path.module}/files/backup/docker-compose.yml")
    backup_entrypoint = base64encode(templatefile("${path.module}/files/backup/entrypoint.sh", {
      minio_bucket = var.rancher_backup_minio_bucket
    }))
    backup_config = base64encode(templatefile("${path.module}/files/backup/config.json", {
      minio_url        = var.rancher_backup_minio_url
      minio_access_key = var.rancher_backup_minio_access_key
      minio_secret_key = var.rancher_backup_minio_secret_key
    }))
    hostname = var.rancher_server_fqdn
    ipa_otp  = var.rancher_server_ipa_otp
  })

  network {
    name        = data.openstack_networking_network_v2.network.name
    fixed_ip_v4 = var.rancher_server_ip_v4
  }
}

resource "openstack_compute_volume_attach_v2" "rancher_data" {
  instance_id = openstack_compute_instance_v2.rancher_server.id
  volume_id   = openstack_blockstorage_volume_v3.rancher_data.id
  device      = "/dev/vdb"
}
