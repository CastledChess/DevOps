resource "random_password" "pgadmin_password" {
  count = var.pgadmin_enabled ? 1 : 0

  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "helm_release" "pgadmin" {
  count = var.pgadmin_enabled ? 1 : 0

  name = "pgadmin4"

  namespace        = var.k8s_ops_namespace
  create_namespace = true

  repository = "https://helm.runix.net"
  chart      = "pgadmin4"
  version    = "1.28.0"

  set {
    name  = "env.email"
    value = var.pgadmin_admin_email
  }

  set {
    name  = "persistentVolume.enabled"
    value = tostring(var.pgadmin_enable_persistence)
  }

  set_sensitive {
    name  = "env.password"
    value = random_password.pgadmin_password[0].result
  }

  depends_on = [kubernetes_namespace.supervision]
}

module "pgadmin_creds" {
  source = "../../modules/scw_secret"

  name = "pgadmin-credentials"

  data = {
    username = var.pgadmin_admin_email
    password = random_password.pgadmin_password[0].result
  }
}
