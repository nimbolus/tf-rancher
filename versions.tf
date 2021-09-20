terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.43.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.1.2"
    }
    k8sbootstrap = {
      source  = "nimbolus/k8sbootstrap"
      version = ">= 0.1.1"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.11.1"
    }
  }
}
