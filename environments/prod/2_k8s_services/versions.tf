terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }

    kubectl = {
      # required by k8s addon cert-manager
      source  = "alekc/kubectl"
      version = "~> 2.0"
    }

    scaleway = {
      source  = "scaleway/scaleway"
      version = "~> 2.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }

    time = {
      source  = "hashicorp/time"
      version = "~> 0.0"
    }
  }
  required_version = "~> 1.0"
}
