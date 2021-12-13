resource "kubernetes_namespace" "cattle_resources_system" {
  provider = kubernetes.rancher_cluster

  metadata {
    name = "cattle-resources-system"
  }

  lifecycle {
    ignore_changes = [
      metadata.0.annotations,
      metadata.0.labels
    ]
  }
}

resource "helm_release" "rancher_backup_crd" {
  provider = helm.rancher_cluster
  count    = var.rancher_backup_enabled ? 1 : 0

  name       = "rancher-backup-crd"
  namespace  = kubernetes_namespace.cattle_resources_system.metadata.0.name
  repository = "https://charts.rancher.io"
  chart      = "rancher-backup-crd"
  version    = var.rancher_backup_chart_version
}

resource "helm_release" "rancher_backup" {
  provider = helm.rancher_cluster
  count    = var.rancher_backup_enabled ? 1 : 0

  name       = "rancher-backup"
  namespace  = kubernetes_namespace.cattle_resources_system.metadata.0.name
  repository = "https://charts.rancher.io"
  chart      = "rancher-backup"
  version    = var.rancher_backup_chart_version

  values = var.rancher_backup_chart_values

  depends_on = [
    helm_release.rancher_backup_crd
  ]
}
