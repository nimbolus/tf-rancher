terraform {
  required_providers {
    rancher2 = {
      source  = "rancher/rancher2"
      version = "1.20.0"
    }
    random = {
      source = "hashicorp/random"
    }
  }
  required_version = ">= 1.0"
}
