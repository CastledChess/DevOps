terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }

    kubectl = {
      # required by k8s addon cert-manager
      source  = "alekc/kubectl"
      version = "~> 2.0"
    }
  }
  required_version = "~> 1.0"
}
