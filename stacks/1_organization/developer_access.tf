module "developer_access_iam_app" {
  for_each = toset(var.project_names)

  source = "../../modules/iam_app"

  project_name = title(each.value)
  name         = "Developer Access"
  policies = [
    {
      policy_name          = "Developer FullAccess"
      permission_set_names = ["AllProductsFullAccess"]
    },
    {
      policy_name            = "Developer IAMManager"
      permission_set_names   = ["IAMManager", "ProjectReadOnly"]
      is_organization_policy = true
    }
  ]

  depends_on = [scaleway_account_project.projects]
}

module "developer_access_secret" {
  count = var.should_create_developer_access_app ? 1 : 0

  source = "../../modules/scw_secret"

  name        = "developer-access-credentials"
  description = "Developer access credentials"
  data        = local.developer_access_credentials
}

locals {
  developer_access_credentials = {
    for p in var.project_names :
    (p) => module.developer_access_iam_app[p].api_keys
  }
}
