module "cicd_access" {
  count = var.should_create_cicd_registry_access ? 1 : 0

  source = "../../modules/iam_app"

  name = "${local.app_name} CICD registry access"
  policies = [{
    policy_name          = "${local.app_name} ContainerRegistryFullAccess"
    permission_set_names = ["ContainerRegistryFullAccess"]
  }]
}
