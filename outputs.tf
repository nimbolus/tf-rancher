output "secgroup_id" {
  value = module.cluster.secgroup_id
}

output "kubeconfig" {
  value     = data.k8sbootstrap_auth.auth.kubeconfig
  sensitive = true
}

output "k3s_url" {
  value = module.cluster.k3s_url
}

output "cluster_token" {
  value = module.cluster.cluster_token
}

output "ca_crt" {
  value = data.k8sbootstrap_auth.auth.ca_crt
}

output "rancher_bootstrap_password" {
  value = random_password.rancher_bootstrap_password.result
}
