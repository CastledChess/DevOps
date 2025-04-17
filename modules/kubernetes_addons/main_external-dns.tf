resource "helm_release" "external_dns" {
  count = var.external_dns_enabled ? 1 : 0

  repository       = "oci://registry-1.docker.io/bitnamicharts"
  chart            = "external-dns"
  name             = "external-dns"
  namespace        = "external-dns"
  version          = "8.7.7"

  create_namespace = true

  dynamic "set" {
    for_each = var.external_dns_set
    content {
      name  = set.key
      value = set.value
    }
  }
}
