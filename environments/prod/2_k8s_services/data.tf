data "scaleway_secret_version" "cloudflare_api_token" {
  secret_name = local.cloudflare_api_token_secret_name
  revision    = "latest"
}

data "scaleway_k8s_cluster" "this" {
  name = "castledchess-prod"
}
