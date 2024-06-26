# Terraform Module - Rancher

Sets up a Rancher (Platform for Kubernetes Management) cluster on top of OpenStack.

For an overview of the options, checkout [variables.tf](./variables.tf)

## Example

```terraform
resource "openstack_compute_keypair_v2" "rancher_cluster" {
  name = "rancher-cluster"
}

module "rancher" {
  source = "git::https://github.com/nimbolus/tf-rancher.git?ref=v0.7.0"

  cluster_availability_zone   = "nova"
  cluster_image_name          = "ubuntu-20.04"
  cluster_key_pair            = openstack_compute_keypair_v2.rancher_cluster.name
  cluster_server_group_policy = "anti-affinity"
  cluster_network_id          = data.openstack_networking_network_v2.rancher.id
  cluster_subnet_id           = data.openstack_networking_subnet_v2.rancher.id
  rancher_hostname            = "rancher.example.com"
}

output "rancher_cluster_kubeconfig" {
  value     = module.rancher.kubeconfig
  sensitive = true
}

provider "rancher2" {
  alias = "bootstrap"

  api_url   = "https://rancher.example.com"
  bootstrap = true
}

resource "rancher2_bootstrap" "admin" {
  provider = rancher2.bootstrap

  current_password = module.rancher.rancher_bootstrap_password
  password         = module.rancher.rancher_bootstrap_password
  telemetry        = false
}

provider "rancher2" {
  api_url   = rancher2_bootstrap.admin.url
  token_key = rancher2_bootstrap.admin.token
}

module "rancher_sa_test" {
  source = "git::https://github.com/nimbolus/tf-rancher.git//service-account?ref=v0.7.0"

  name  = "test"
  email = "test@example.com"
}
```

## Upgrade Notes

### v0.7.0

Upgrade to `v0.6.1` first and migrate kubectl provider resources if needed:
```sh
tofu state rm module.rancher.kubectl_manifest.cluster_issuer
tofu state rm module.rancher.kubectl_manifest.rancher_certificate
tofu import 'module.rancher.kubernetes_manifest.cluster_issuer[0]' \
  "apiVersion=cert-manager.io/v1kind=ClusterIssuser,name=letsencrypt"
tofu import 'module.rancher.kubernetes_manifest.rancher_certificate[0]' \
  "apiVersion=cert-manager.iov1,kind=Certificate,namespace=cattle-system,name=rancher"
```

Then upgrade to `v0.7.0`
