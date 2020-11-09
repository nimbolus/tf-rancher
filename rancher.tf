resource "random_password" "rancher_admin_password" {
  length           = 32
  special          = true
  override_special = "_$%&?!@+#"
}

provider "rancher2" {
  alias     = "bootstrap"
  api_url   = "https://${var.rancher_server_fqdn}"
  bootstrap = true
}

resource "rancher2_bootstrap" "admin" {
  provider  = rancher2.bootstrap
  password  = random_password.rancher_admin_password.result
  telemetry = false
}

provider "rancher2" {
  alias     = "auth"
  api_url   = "https://${var.rancher_server_fqdn}"
  token_key = rancher2_bootstrap.admin.token
}

resource "rancher2_auth_config_freeipa" "freeipa" {
  provider                           = rancher2.auth
  count                              = var.auth_freeipa_enabled ? 1 : 0
  servers                            = [var.auth_freeipa_server]
  service_account_distinguished_name = var.auth_freeipa_service_account_dn
  service_account_password           = var.auth_freeipa_service_account_password
  user_search_base                   = "cn=users,cn=accounts,${var.auth_freeipa_base_dn}"
  group_search_base                  = "cn=groups,cn=accounts,${var.auth_freeipa_base_dn}"
  certificate                        = var.auth_freeipa_ca_certificate
  user_search_attribute              = "uid"
  tls                                = true
  port                               = "636"
  test_username                      = var.auth_freeipa_test_username
  test_password                      = var.auth_freeipa_test_password
}
