terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
    }
    rancher2 = {
      source = "rancher/rancher2"
    }
  }
  required_version = ">= 0.13"
}
