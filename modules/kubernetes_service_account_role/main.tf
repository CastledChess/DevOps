resource "kubernetes_service_account" "this" {
  metadata {
    name      = var.name
    namespace = var.namespace
  }
}

resource "kubernetes_role" "this" {
  metadata {
    name      = var.name
    namespace = var.namespace
  }

  dynamic "rule" {
    for_each = var.rules
    content {
      api_groups = rule.value["api_groups"]
      resources  = rule.value["resources"]
      verbs      = rule.value["verbs"]
    }
  }
}

resource "kubernetes_role_binding" "this" {
  metadata {
    name      = var.name
    namespace = var.namespace
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = var.name
  }
  subject {
    kind      = "ServiceAccount"
    name      = var.name
    namespace = var.namespace
    api_group = ""
  }
}
