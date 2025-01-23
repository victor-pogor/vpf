resource "kubernetes_namespace_v1" "cert_manager_namespace" {
  metadata {
    name = "cert-manager"
  }
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  namespace  = kubernetes_namespace_v1.cert_manager_namespace.metadata[0].name
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.16.3"

  set {
    name  = "crds.enabled"
    value = true
  }
}

resource "kubernetes_manifest" "selfsigned_clusterissuer" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata = {
      name = var.cert_manager.cluster_issuers.selfsigned.name
    }
    spec = {
      selfSigned = {}
    }
  }
}