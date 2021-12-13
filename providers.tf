data "k8sbootstrap_auth" "auth" {
  server = module.cluster.k3s_url
  token  = module.cluster.cluster_token
}

provider "kubernetes" {
  alias                  = "rancher_cluster"
  host                   = module.cluster.k3s_url
  token                  = module.cluster.cluster_token
  cluster_ca_certificate = data.k8sbootstrap_auth.auth.ca_crt
}

provider "helm" {
  alias = "rancher_cluster"
  kubernetes {
    host                   = module.cluster.k3s_url
    token                  = module.cluster.cluster_token
    cluster_ca_certificate = data.k8sbootstrap_auth.auth.ca_crt
  }
}

provider "kubectl" {
  alias                  = "rancher_cluster"
  host                   = module.cluster.k3s_url
  token                  = module.cluster.cluster_token
  cluster_ca_certificate = data.k8sbootstrap_auth.auth.ca_crt
  load_config_file       = false
}
