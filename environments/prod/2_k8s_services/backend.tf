terraform {
  backend "s3" {
    bucket = "castledchess-prod-tfstate"
    key    = "2_k8s_services.tfstate"
    region = "fr-par"
    endpoints = {
      s3 = "https://s3.fr-par.scw.cloud"
    }
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
  }
}
