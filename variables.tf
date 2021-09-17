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

variable "auth_freeipa_enabled" {
  default = false
}

variable "auth_freeipa_server" {
  type    = string
  default = "ipa.example.com"
}

variable "auth_freeipa_service_account_dn" {
  type    = string
  default = "krbprincipalname=rancher/rancher.example.de@EXAMPLE.COM,cn=services,cn=accounts,dc=example,dc=com"
}

variable "auth_freeipa_service_account_password" {
  type    = string
  default = "verysecret"
}

variable "auth_freeipa_base_dn" {
  type    = string
  default = "dc=example,dc=com"
}

variable "auth_freeipa_ca_certificate" {
  type        = string
  default     = null
  description = "base64 encoded freeipa ca certificate"
}

variable "auth_freeipa_test_username" {
  type    = string
  default = "john.doe"
}

variable "auth_freeipa_test_password" {
  type    = string
  default = "secret"
}

variable "cattle_security_group_cidr" {
  default = "0.0.0.0/0"
}
