module "ops" {
  source = "../../../stacks/4_ops"

  pgadmin_enabled     = true
  pgadmin_admin_email = "admin@castled.app"
}
