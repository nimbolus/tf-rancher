resource "random_password" "rancher_bootstrap_password" {
  length  = 32
  special = true
}

resource "kubernetes_namespace" "ingress_nginx" {
  provider = kubernetes.rancher_cluster

  metadata {
    name = "ingress-nginx"
  }

  lifecycle {
    ignore_changes = [
      metadata.0.annotations,
      metadata.0.labels,
    ]
  }
}

resource "kubernetes_namespace" "cert_manager" {
  provider = kubernetes.rancher_cluster

  metadata {
    name = "cert-manager"
  }

  lifecycle {
    ignore_changes = [
      metadata.0.annotations,
      metadata.0.labels,
    ]
  }
}

resource "kubernetes_namespace" "cattle_system" {
  provider = kubernetes.rancher_cluster

  metadata {
    name = "cattle-system"
  }

  lifecycle {
    ignore_changes = [
      metadata.0.annotations,
      metadata.0.labels,
    ]
  }
}

resource "helm_release" "ingress_nginx" {
  provider = helm.rancher_cluster

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  name       = "ingress-nginx"
  namespace  = kubernetes_namespace.ingress_nginx.metadata.0.name
  version    = "4.7.0"
  values = [<<-EOT
    controller:
      replicaCount: 2
      watchIngressWithoutClass: true
    EOT
  ]
}

resource "helm_release" "cert_manager" {
  provider = helm.rancher_cluster

  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  name       = "cert-manager"
  namespace  = kubernetes_namespace.cert_manager.metadata.0.name
  version    = "v1.12.1"
  values = [<<-EOT
    installCRDs: true
    extraArgs:
      - --dns01-recursive-nameservers-only
      - --dns01-recursive-nameservers=9.9.9.9:53,8.8.8.8:53
    EOT
  ]
}

locals {
  ingress_tls_source = var.cert_manager_cluster_issuer_yaml != null ? "secret" : "rancher"
}

resource "kubectl_manifest" "cluster_issuer" {
  provider = kubectl.rancher_cluster
  count    = local.ingress_tls_source == "secret" ? 1 : 0

  yaml_body = var.cert_manager_cluster_issuer_yaml

  depends_on = [
    helm_release.cert_manager,
  ]
}

resource "kubectl_manifest" "rancher_certificate" {
  provider = kubectl.rancher_cluster
  count    = local.ingress_tls_source == "secret" ? 1 : 0

  yaml_body = <<-EOT
    apiVersion: cert-manager.io/v1
    kind: Certificate
    metadata:
      name: rancher
      namespace: ${kubernetes_namespace.cattle_system.metadata.0.name}
    spec:
      secretName: tls-rancher-ingress
      issuerRef:
        name: ${var.cert_manager_cluster_issuer_name}
        kind: ClusterIssuer
      dnsNames:
        - "${var.rancher_hostname}"
    EOT

  depends_on = [
    kubectl_manifest.cluster_issuer,
  ]
}

locals {
  rancher_replicas = var.rancher_replicas == null ? var.cluster_size : var.rancher_replicas
}

resource "helm_release" "rancher" {
  provider = helm.rancher_cluster

  repository = "https://releases.rancher.com/server-charts/latest"
  chart      = "rancher"
  name       = "rancher"
  namespace  = kubernetes_namespace.cattle_system.metadata.0.name
  version    = var.rancher_chart_version

  values = [<<-EOT
    rancherImage: ${var.rancher_image_repo}
    %{ if var.rancher_image_tag != null }
    rancherImageTag: ${var.rancher_image_tag}
    %{ endif }
    hostname: ${var.rancher_hostname}
    replicas: ${local.rancher_replicas}
    ingress:
      extraAnnotations:
        # fix error code 413 with large helm deployments
        "nginx.ingress.kubernetes.io/proxy-body-size": "512m"
      tls:
        source: ${local.ingress_tls_source}
    EOT
  ]

  set_sensitive {
    name  = "bootstrapPassword"
    value = random_password.rancher_bootstrap_password.result
  }

  depends_on = [
    kubectl_manifest.rancher_certificate,
    helm_release.ingress_nginx,
  ]
}
