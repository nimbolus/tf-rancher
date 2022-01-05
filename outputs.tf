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

output "cattle_resources_system_namespace" {
  value = kubernetes_namespace.cattle_resources_system.metadata.0.name
}

output "servers_node_ips" {
  value = module.cluster.servers_node_ips
}

output "servers_node_external_ips" {
  value = module.cluster.servers_node_external_ips
}
