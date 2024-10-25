# Définir le déploiement pour le frontend
resource "kubernetes_deployment" "frontend_deployment" {
  metadata {
    name      = "${var.frontend_name}-deployment"
    namespace = "frontend"
    labels = {
      app = "frontend"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "frontend"
      }
    }

    template {
      metadata {
        labels = {
          app = "frontend"
        }
      }

      spec {
        container {
          name  = "frontend-container"
          image = "${var.docker_hub_username}/${var.frontend_name}:latest"

          port {
            container_port = 80
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

# Kubernetes Service for frontend
resource "kubernetes_service" "frontend_service" {
  metadata {
    name      = "${var.frontend_name}-service"
    namespace = "frontend"
  }

  spec {
    selector = {
      app = "frontend"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}
