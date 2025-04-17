variable "scw_project_name" {
  type    = string
  default = null
}

# Cert Manager
variable "cert_manager_enabled" {
  type    = bool
  default = true
}

variable "cert_manager_set" {
  type    = any
  default = {}
}


# External DNS
variable "external_dns_enabled" {
  type    = bool
  default = true
}

variable "external_dns_set" {
  type    = map(string)
  default = {}
}


# Nginx Controller
variable "nginx_controller_enabled" {
  type    = bool
  default = true
}

variable "nginx_controller_set" {
  type    = any
  default = {}
}


# ArgoCD
variable "argocd_enabled" {
  type    = bool
  default = true
}

variable "argocd_exposed_to_internet" {
  type    = bool
  default = false
}

variable "argocd_sets" {
  type    = map(string)
  default = {}
}

variable "argocd_domain_name" {
  type    = string
  default = null
}

variable "argocd_image_updater_enabled" {
  type    = bool
  default = true
}

variable "argocd_image_updater_sets" {
  type    = map(string)
  default = {}
}


# KEDA
variable "keda_enabled" {
  type    = bool
  default = true
}


# External secret
variable "external_secrets_enabled" {
  type    = bool
  default = true
}

variable "external_secrets_allowed_namespaces" {
  type    = list(string)
  default = ["external-secrets"]
}

variable "external_secrets_secret_store_enabled" {
  type    = bool
  default = false
}


# Reloader
variable "reloader_enabled" {
  type    = bool
  default = true
}


# Monitoring
variable "monitoring_enabled" {
  type    = bool
  default = true
}

variable "monitoring_grafana_host" {
  type    = string
  default = ""
}
