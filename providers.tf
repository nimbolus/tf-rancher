provider "kubernetes" {
  alias                  = "rancher_cluster"
  host                   = module.cluster.k3s_url
  token                  = module.cluster.cluster_token
  cluster_ca_certificate = module.cluster.cluster_ca_certificate
}

provider "helm" {
  alias = "rancher_cluster"
  kubernetes {
    host                   = module.cluster.k3s_url
    token                  = module.cluster.cluster_token
    cluster_ca_certificate = module.cluster.cluster_ca_certificate
  }
}

provider "kubectl" {
  alias                  = "rancher_cluster"
  host                   = module.cluster.k3s_url
  token                  = module.cluster.cluster_token
  cluster_ca_certificate = module.cluster.cluster_ca_certificate
  load_config_file       = false
}
