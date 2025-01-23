variable "kubeconfig" {
  description = "The Kubernetes configuration"
  type = object({
    config_path     = string
    default_context = string
  })
}

variable "apisix_dashboard" {
  description = "The Apisix dashboard configuration"
  type = object({
    host = string
    username = string
    password = string
  })
}

variable "cert_manager" {
  description = "The Cert Manager configuration"
  type = object({
    cluster_issuers = map(object({
      name = string
    }))
  })
}