output "rancher_token" {
  value     = rancher2_bootstrap.admin.token
  sensitive = true
}

output "rancher_admin_password" {
  value     = random_password.rancher_admin_password.result
  sensitive = true
}
