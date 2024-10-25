# Définir le déploiement pour l'API
resource "kubernetes_deployment" "api_deployment" {
  metadata {
    name      = "${var.api_name}-deployment"
    namespace = "api"
    labels = {
      app = "api"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "api"
      }
    }

    template {
      metadata {
        labels = {
          app = "api"
        }
      }

      spec {
        container {
          name  = "api-container"
          image = "${var.docker_hub_username}/${var.api_name}:latest"

          port {
            container_port = 3000
          }

          env {
            name = "NODE_ENV"
            # value = "production"
            value = "development"
          }
        }
      }
    }
  }
}

# Kubernetes Service for API
resource "kubernetes_service" "api_service" {
  metadata {
    name      = "${var.api_name}-service"
    namespace = "api"
  }

  spec {
    selector = {
      app = "api"
    }

    port {
      port        = 80
      target_port = 3000
    }

    type = "LoadBalancer"
  }
}
