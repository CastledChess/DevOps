module "groups" {
  for_each = var.iam_groups

  source = "./iam_group"

  name        = each.key
  tags        = each.value.tags
  description = each.value.description
  policies    = each.value.policies
}

module "users" {
  for_each = var.iam_users

  source = "./iam_user"

  email  = each.key
  groups = [for group in each.value : module.groups[group].id]
}
