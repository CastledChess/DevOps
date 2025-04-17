resource "kubernetes_secret" "aws_nuke_credentials" {
  metadata {
    name      = "aws-nuke-credentials"
    namespace = var.namespace
  }

  depends_on = [
    kubernetes_namespace.aws_nuke_namespace
  ]

  data = merge([
    for account, value in var.aws_accounts : {
      "${account}-key-id"     = value.key_id,
      "${account}-access-key" = value.access_key
    }
  ]...)
}
