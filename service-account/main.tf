resource "random_password" "service_user_password" {
  length           = 32
  special          = true
  override_special = "_$%&?!@+#"
}

resource "rancher2_user" "service_user" {
  name        = "${var.name} Service User"
  username    = "service-user-${var.name}"
  password    = random_password.service_user_password.result
  enabled     = true
  annotations = var.user_annotations
}

resource "rancher2_global_role_binding" "service_user_default" {
  name           = "service-user-${var.name}-default"
  global_role_id = "user"
  user_id        = rancher2_user.service_user.id
}

output "service_user_username" {
  value = rancher2_user.service_user.username
}

output "service_user_password" {
  sensitive = true
  value     = rancher2_user.service_user.password
}
