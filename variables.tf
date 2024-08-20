variable "rancher_name" {
  default = "rancher"
}

variable "rancher_hostname" {
  default = "rancher.example.com"
}

variable "rancher_image_repo" {
  default = "docker.io/rancher/rancher"
}

variable "rancher_image_tag" {
  default = null
  type    = string
}

variable "rancher_chart_version" {
  # registryUrl=https://releases.rancher.com/server-charts/stable depName=rancher
  default = "2.8.5"
}

variable "rancher_replicas" {
  default     = null
  description = "defaults to cluster_size"
}

variable "rancher_ip_whitelist" {
  default = "0.0.0.0/0"
}

variable "rancher_backup_enabled" {
  default = false
}

variable "rancher_backup_chart_version" {
  # registryUrl=https://charts.rancher.io depName=rancher-backup
  default = "103.0.3+up4.0.3"
}

variable "rancher_backup_chart_values" {
  default = []
}

variable "cluster_availability_zone" {
  default = "nova"
}

variable "cluster_size" {
  default = 1
}

variable "cluster_image_name" {
  default = "ubuntu-20.04"
}

variable "cluster_image_id" {
  default = null
}

variable "cluster_image_scsi_bus" {
  default = false
}

variable "cluster_flavor_name" {
  default = "m1.medium"
}

variable "cluster_data_volume_type" {
  default = "__DEFAULT__"
}

variable "cluster_data_volume_size" {
  default = 10
}

variable "cluster_key_pair" {
  type    = string
  default = null
}

variable "cluster_server_group_policy" {
  default = "soft-anti-affinity"
}

variable "cluster_floating_ip_pool" {
  default = null
}

variable "cluster_server1_floating_ip" {
  default = false
}
variable "cluster_servers_floating_ip" {
  default = false
}

variable "cluster_network_id" {
  type = string
}

variable "cluster_subnet_id" {
  type = string
}

variable "cluster_instance_properties" {
  default = {}
}

variable "cluster_k3s_version" {
  default = null
}

variable "cluster_k3s_channel" {
  default = "v1.21"
}

variable "cert_manager_cluster_issuer_name" {
  default = "letsencrypt"
}

variable "cert_manager_cluster_issuer_yaml" {
  default = null
}
