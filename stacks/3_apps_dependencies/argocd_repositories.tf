resource "kubernetes_secret" "repositories" {
  for_each = var.argocd_repositories_secrets

  metadata {
    name      = "repository-${each.key}"
    namespace = "argocd"
    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
    }
  }

  data = {
    url                           = each.value.url
    enable_lfs                    = each.value.enable_lfs
    enable_oci                    = each.value.enable_oci
    githubapp_enterprise_base_url = each.value.githubapp_enterprise_base_url
    githubapp_id                  = each.value.githubapp_id
    githubapp_installation_id     = each.value.githubapp_installation_id
    githubapp_private_key         = each.value.githubapp_private_key
    insecure                      = each.value.insecure
    name                          = each.value.name
    password                      = each.value.password
    project                       = each.value.project
    ssh_private_key               = each.value.ssh_private_key
    tls_client_cert_data          = each.value.tls_client_cert_data
    tls_client_cert_key           = each.value.tls_client_cert_key
    type                          = each.value.type
    username                      = each.value.username
  }
}

resource "kubernetes_secret" "repository_credentials" {
  for_each = var.argocd_repository_credentials_secrets

  metadata {
    name      = "repository-credentials-${each.key}"
    namespace = "argocd"
    labels = {
      "argocd.argoproj.io/secret-type" = "repo-creds"
    }
  }

  data = {
    url                           = each.value.url
    enable_lfs                    = each.value.enable_lfs
    enable_oci                    = each.value.enable_oci
    githubapp_enterprise_base_url = each.value.githubapp_enterprise_base_url
    githubapp_id                  = each.value.githubapp_id
    githubapp_installation_id     = each.value.githubapp_installation_id
    githubapp_private_key         = each.value.githubapp_private_key
    insecure                      = each.value.insecure
    name                          = each.value.name
    password                      = each.value.password
    project                       = each.value.project
    ssh_private_key               = each.value.ssh_private_key
    tls_client_cert_data          = each.value.tls_client_cert_data
    tls_client_cert_key           = each.value.tls_client_cert_key
    type                          = each.value.type
    username                      = each.value.username
  }
}
