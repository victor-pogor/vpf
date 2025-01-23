terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.17.0"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path    = var.kubeconfig.config_path
    config_context = var.kubeconfig.default_context
  }
}

provider "kubernetes" {
  config_path    = var.kubeconfig.config_path
  config_context = var.kubeconfig.default_context
}
