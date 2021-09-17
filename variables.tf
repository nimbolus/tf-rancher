variable "network_id" {
  type = string
}

variable "availability_zone" {
  default = "nova"
}

variable "rancher_server_name" {
  default = "rancher-server"
}

variable "rancher_image" {
  default     = "docker.io/rancher/rancher"
  description = "container image repository and name"
}

variable "rancher_version" {
  default     = "latest"
  description = "image tag (e.g. one of https://hub.docker.com/r/rancher/rancher/tags)"
}

variable "rancher_volume_type" {
  default     = "__DEFAULT__"
  description = "cinder volume type for persistent data"
}

variable "rancher_server_image" {
  default     = "centos-8-stream"
  description = "glance image for the instance (only centos 8 is supported)"
}

variable "rancher_server_flavor" {
  default = "m1.medium"
}

variable "rancher_server_ip_v4" {
  default     = null
  description = "IPv4 address for network port"
}

variable "rancher_server_fqdn" {
  default = "rancher.example.com"
}

variable "rancher_server_key_pair" {
  default = null
}

variable "rancher_server_properties" {
  type        = map(string)
  description = "additional metadata properties for rancher server instance"
  default     = {}
}

variable "rancher_server_post_commands" {
  type        = list(string)
  description = "commands executed at the end of cloud-init script"
  default     = []
}

variable "cattle_security_group_cidr" {
  default = "0.0.0.0/0"
}
