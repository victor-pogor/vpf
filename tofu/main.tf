provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "vpf" {
  metadata {
    name = var.vpf_namespace
  }
}

resource "kubernetes_deployment" "postgresql" {
  metadata {
    name      = var.vpf_postgresql_deployment_name
    namespace = kubernetes_namespace.vpf.metadata[0].name
    labels = {
      app = var.vpf_postgresql_deployment_name
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = var.vpf_postgresql_deployment_template_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.vpf_postgresql_deployment_template_name
        }
      }

      spec {
        container {
          name  = "postgresql"
          image = "timescale/timescaledb:latest-pg14"

          env {
            name  = "POSTGRES_USER"
            value = var.postgres_user
          }

          env {
            name  = "POSTGRES_PASSWORD"
            value = var.postgres_password
          }

          env {
            name  = "POSTGRES_DB"
            value = var.postgres_db
          }

          port {
            container_port = var.postgres_port
          }

          readiness_probe {
            exec {
              command = ["/bin/sh", "-c", "pg_isready -U ${var.postgres_user}"]
            }
            initial_delay_seconds = 10
            period_seconds        = 10
          }

          liveness_probe {
            exec {
              command = ["/bin/sh", "-c", "pg_isready -U ${var.postgres_user}"]
            }
            initial_delay_seconds = 30
            period_seconds        = 10
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "postgresql" {
  metadata {
    name      = var.vpf_postgresql_service_name
    namespace = kubernetes_namespace.vpf.metadata[0].name
  }

  spec {
    selector = {
      app = var.vpf_postgresql_deployment_template_name
    }

    port {
      port        = var.postgres_port
      target_port = var.postgres_port
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_ingress_v1" "postgresql" {
  metadata {
    name      = var.vpf_postgresql_ingress_name
    namespace = kubernetes_namespace.vpf.metadata[0].name
    annotations = {
      "kubernetes.io/ingress.class" = "contour"
    }
  }

  spec {
    rule {
      http {
        path {
          path = "/db"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service.postgresql.metadata[0].name
              port {
                number = var.postgres_port
              }
            }
          }
        }
      }
    }
  }
}
