terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
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
