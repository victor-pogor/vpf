variable "vpf_namespace" {
  description = "The Kubernetes namespace to deploy the application"
  type        = string
  default     = "vpf-namespace"
}

variable "vpf_postgresql_service_name" {
  description = "The name of the PostgreSQL service"
  type        = string
  default     = "vpf-postgresql-service"
}

variable "vpf_postgresql_deployment_name" {
  description = "The name of the PostgreSQL deployment"
  type        = string
  default     = "vpf-postgresql-deploy"
}

variable "vpf_postgresql_deployment_template_name" {
  description = "The name of the PostgreSQL deployment template"
  type        = string
  default     = "vpf-postgresql-deploy-template"
}

variable "vpf_postgresql_ingress_name" {
  description = "The name of the PostgreSQL ingress"
  type        = string
  default     = "vpf-postgresql-ingress"
}