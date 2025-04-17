terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "~> 2.0"
    }

    grafana = {
      source  = "grafana/grafana"
      version = "~> 3.0"
    }
  }
}
