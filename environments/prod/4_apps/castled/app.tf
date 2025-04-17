locals {
  app_namespace     = "castledchess"
#   app_image_name    = "rg.fr-par.scw.cloud/castledchess-prod/castledchess"
#   app_image_version = "latest"

  app_image_name    = "nginx"
  app_image_version = "latest"

  app_annotations = {
    "secret.reloader.stakater.com/reload"                           = "castledchess-secrets"
    "argocd-image-updater.argoproj.io/write-back-method"            = "argocd"
    "argocd-image-updater.argoproj.io/image-list"                   = "castledchess=${local.app_image_name}"
    "argocd-image-updater.argoproj.io/castledchess.update-strategy" = "newest-build"
  }

  castledchess_kube_manager_secret_id = replace(data.scaleway_secret.castledchess_kube_manager.id, "${data.scaleway_secret.castledchess_kube_manager.region}/", "")
}

resource "kubernetes_manifest" "application_castledchess_kube_manager" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name        = "castledchess"
      namespace   = "argocd"
      annotations = local.app_annotations
    }
    spec = {
      destination = {
        namespace = local.app_namespace
        server    = "https://kubernetes.default.svc"
      }
      ignoreDifferences = [
        {
          group = "apps"
          jsonPointers = [
            "/spec/replicas",
          ]
          kind = "Deployment"
        },
        {
          group = "*"
          kind  = "*"
        },
      ]
      project = "default"
      source = {
        helm = {
          releaseName = "castledchess"
          values      = <<-EOT
          fullnameOverride: castledchess

          containers:
            - name: castledchess
              image:
                repository: ${local.app_image_name}
                pullPolicy: IfNotPresent
                tag: ${local.app_image_version}

          cronjobs: []

          secrets: []

          ingress:
            enabled: false

          service:
            enabled: false

          autoscaling:
            enabled: true
            minReplicas: 1
            maxReplicas: 3
            targetMemoryUtilizationPercentage: 80

          livenessProbe:
            enabled: false

          readinessProbe:
            enabled: false
          EOT
          version     = "v3"
        }
        repoURL        = "rg.fr-par.scw.cloud/keltio-charts"
        chart          = "app-component"
        targetRevision = "3.14.0"
      }
      syncPolicy = {
        automated = {
          prune    = true
          selfHeal = true
        }
        retry = {
          backoff = {
            duration    = "30s"
            factor      = 2
            maxDuration = "2m"
          }
          limit = 5
        }
        syncOptions = [
          "Validate=false",
          "CreateNamespace=true",
          "PrunePropagationPolicy=foreground",
          "PruneLast=true",
        ]
      }
    }
  }
}
