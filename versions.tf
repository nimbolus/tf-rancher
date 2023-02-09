terraform {
  required_version = ">= 1.0.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
    }
    helm = {
      source  = "hashicorp/helm"
    }
    k8sbootstrap = {
      source  = "nimbolus/k8sbootstrap"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
    }
  }
}
