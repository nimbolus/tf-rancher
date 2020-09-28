variable "network_name" {
  type = string
}

variable "availability_zone" {
  default = "nova"
}

variable "rancher_version" {
  default     = "latest"
  description = "image tag from https://hub.docker.com/r/rancher/rancher/tags"
}

variable "rancher_volume_type" {
  default     = "ssd"
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
  default = null
}

variable "rancher_server_fqdn" {
  default = "rancher.example.com"
}

variable "rancher_server_ipa_otp" {
  type        = string
  description = "freeipa otp for joining the domain"
}

variable "backup_minio_url" {
  default     = "https://minio.exmaple.com"
  description = "minio s3 server for storing backups"
}

variable "backup_minio_bucket" {
  default = "rancher-backups"
}

variable "backup_minio_access_key" {
  default = "rancher"
}

variable "backup_minio_secret_key" {
  default = "verysecret"
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
  default     = ""
  description = "base64 encoded freeipa ca certificate"
}
