terraform {
  required_providers {
    openstack = {
      source = "terraform-providers/openstack"
    }
    rancher2 = {
      source = "rancher/rancher2"
    }
  }
  required_version = ">= 0.13"
}
