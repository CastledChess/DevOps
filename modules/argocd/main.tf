locals {
  default_sets = {
    "server.https" = "true"
  }

  exposed_to_internet_sets = {
    "server.ingress.enabled" = "true"

    "server.ingress.annotations.external-dns\\.alpha\\.kubernetes\\.io/hostname"      = var.domain_name
    "server.ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/force-ssl-redirect" = "true"
    "server.ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/backend-protocol"   = "HTTPS"
    "server.ingress.hosts[0]"                                                         = var.domain_name
    "server.ingress.annotations.cert-manager\\.io/cluster-issuer"                     = "cert-manager"
    "server.ingress.ingressClassName"                                                 = "nginx"
    "server.ingress.tls[0].hosts[0]"                                                  = var.domain_name
    "server.ingress.tls[0].secretName"                                                = "argocd-secret"
  }

  sets = merge(
    local.default_sets,
    var.exposed_to_internet ? local.exposed_to_internet_sets : {},
    var.sets,
  )
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  name       = "argocd"
  namespace  = "argocd"

  dynamic "set" {
    for_each = local.sets
    content {
      name  = set.key
      value = set.value
    }
  }

  # High availability
  # "redis-ha.enabled"    = true
  # "controller.replicas" = 1

  # "server.autoscaling.enabled"     = true
  # "server.autoscaling.minReplicas" = 2

  # "repoServer.autoscaling.enabled"     = true
  # "repoServer.autoscaling.minReplicas" = 2

  # "applicationSet.replicaCount" = 2
}

resource "helm_release" "argocd_image_updater" {
  count = var.argocd_image_updater_enabled ? 1 : 0

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argocd-image-updater"
  name       = "argocd-image-updater"
  namespace  = "argocd"

  # # NOTE is this required as they run alongside?
  # set {
  #   name = "config.argocd.serverAddress"
  #   # FIXME
  #   # value = "argocd-server.argocd" # :80
  #   value = "https://${var.domain_name}"
  # }

  dynamic "set" {
    for_each = var.argocd_image_updater_sets
    content {
      name  = set.key
      value = set.value
    }
  }
}
