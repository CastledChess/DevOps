## Kubernetes
variable "k8s_namespaces" {
  type    = list(string)
  default = []
}

## Buckets
variable "scaleway_buckets" {
  type = map(object({
    acl             = optional(string, "private")
    region          = optional(string)
    tags            = optional(map(string), {})
    lifecycle_rules = optional(map(any), {})
  }))
  default = {}
}

## Container registry
variable "scaleway_repository_registries" {
  type = map(object({
    name        = string
    description = optional(string)
    is_public   = optional(bool)
    region      = optional(string)
    project_id  = optional(string)
  }))
  default = {}
}

## ArgoCD
variable "argocd_repositories_secrets" {
  type = map(object({
    url                           = string
    enable_lfs                    = optional(bool)
    enable_oci                    = optional(bool)
    githubapp_enterprise_base_url = optional(string)
    githubapp_id                  = optional(string)
    githubapp_installation_id     = optional(string)
    githubapp_private_key         = optional(string)
    insecure                      = optional(bool)
    name                          = optional(string)
    password                      = optional(string)
    project                       = optional(string)
    ssh_private_key               = optional(string)
    tls_client_cert_data          = optional(string)
    tls_client_cert_key           = optional(string)
    type                          = optional(string)
    username                      = optional(string)
  }))
  default = {}
}

variable "argocd_repository_credentials_secrets" {
  type = map(object({
    url                           = string
    enable_lfs                    = optional(bool)
    enable_oci                    = optional(bool)
    githubapp_enterprise_base_url = optional(string)
    githubapp_id                  = optional(string)
    githubapp_installation_id     = optional(string)
    githubapp_private_key         = optional(string)
    insecure                      = optional(bool)
    name                          = optional(string)
    password                      = optional(string)
    project                       = optional(string)
    ssh_private_key               = optional(string)
    tls_client_cert_data          = optional(string)
    tls_client_cert_key           = optional(string)
    type                          = optional(string)
    username                      = optional(string)
  }))
  default = {}
}

variable "argocd_additional_registries" {
  type = map(object({
    name        = string
    prefix      = string
    api_url     = optional(string)
    defaultns   = optional(string)
    default     = optional(bool)
    credentials = optional(string)
    credsexpire = optional(string)
    insecure    = optional(bool)
    limit       = optional(number)
  }))
  default = {}
}

## External secret
variable "external_secrets" {
  type = map(object({
    name               = string
    namespace          = string
    scaleway_secret_id = string
  }))
  default = {}
}

## IAM App
variable "app_name" {
  type = string
}

variable "should_create_s3_access" {
  type    = bool
  default = false
}

variable "should_create_cicd_registry_access" {
  type    = bool
  default = false
}

variable "should_create_argocd_registry_access" {
  type    = bool
  default = false
}
