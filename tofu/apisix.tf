resource "kubernetes_namespace_v1" "apisix_namespace" {
  metadata {
    name = "apisix"
  }
}

resource "kubernetes_namespace_v1" "apisix_dashboard_namespace" {
  metadata {
    name = "apisix-dashboard"
  }
}

resource "kubernetes_namespace_v1" "apisix_ingress_namespace" {
  metadata {
    name = "apisix-ingress"
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
  namespace  = kubernetes_namespace_v1.apisix_dashboard_namespace.metadata[0].name
  repository = "https://charts.apiseven.com"
  chart      = "apisix-dashboard"
  version    = "0.8.2"
  values = [templatefile("${path.module}/config/apisix_dashboard.yaml", {
    host                     = var.apisix_dashboard.host
    selfsigned_name          = var.cert_manager.cluster_issuers.selfsigned.name
    username                 = var.apisix_dashboard.username
    password                 = var.apisix_dashboard.password
    apisix_service_namespace = kubernetes_namespace_v1.apisix_namespace.metadata[0].name
  })]
}

resource "helm_release" "apisix_ingress_controller" {
  name       = "apisix-ingress-controller"
  namespace  = kubernetes_namespace_v1.apisix_ingress_namespace.metadata[0].name
  repository = "https://charts.apiseven.com"
  chart      = "apisix-ingress-controller"
  version    = "0.14.0"
  values = [templatefile("${path.module}/config/apisix_ingress_controller.yaml", {
    apisix_service_namespace = kubernetes_namespace_v1.apisix_namespace.metadata[0].name
  })]
}
