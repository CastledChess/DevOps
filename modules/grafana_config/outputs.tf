# output "loki" {
#   description = "Loki configurations"
#   value = {
#     token    = scaleway_cockpit_token.loki.secret_key
#     endpoint = scaleway_cockpit_source.this["logs"].url
#   }
#   sensitive = true
# }
