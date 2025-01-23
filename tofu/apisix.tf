resource "kubernetes_namespace_v1" "apisix_namespace" {
  metadata {
    name = "ingress-apisix"
  }
}

resource "helm_release" "apisix" {
  name       = "apisix"
  namespace  = kubernetes_namespace_v1.apisix_namespace.metadata[0].name
  repository = "https://charts.apiseven.com"
  chart      = "apisix"
  version    = "2.10.0"
}

resource "helm_release" "apisix_dashboard" {
  name       = "apisix-dashboard"
  namespace  = kubernetes_namespace_v1.apisix_namespace.metadata[0].name
  repository = "https://charts.apiseven.com"
  chart      = "apisix-dashboard"
  version    = "0.8.2"
  values = [templatefile("${path.module}/config/apisix_dashboard_values.yaml", {
    host            = var.apisix_dashboard.host
    selfsigned_name = var.cert_manager.cluster_issuers.selfsigned.name
    username        = var.apisix_dashboard.username
    password        = var.apisix_dashboard.password
  })]
}
