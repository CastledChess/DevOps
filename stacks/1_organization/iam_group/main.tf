module "provider_infos" { source = "../../../modules/scw_provider_infos" }

resource "scaleway_iam_group" "this" {
  organization_id = module.provider_infos.organization_id

  name        = var.name
  description = var.description

  tags = [for key, value in var.tags : "${key}=${value}"]
}

resource "scaleway_iam_policy" "this" {
  name     = "${var.name} Policy"
  group_id = scaleway_iam_group.this.id


  dynamic "rule" {
    for_each = var.policies

    content {
      permission_set_names = [rule.value.permission_set]
      project_ids          = rule.value.scope_type == "project" ? rule.value.project_scope : null
      organization_id      = rule.value.scope_type == "organization" ? module.provider_infos.organization_id : null
    }
  }
}
