data "scaleway_account_project" "this" {
  name = var.project_name
}

resource "scaleway_iam_application" "this" {
  name = "${var.name} - ${data.scaleway_account_project.this.name}"
}

resource "scaleway_iam_api_key" "this" {
  count = var.create_api_key ? 1 : 0

  application_id     = scaleway_iam_application.this.id
  default_project_id = data.scaleway_account_project.this.id
}

resource "scaleway_iam_policy" "this" {
  for_each = { for p in var.policies : p.policy_name => p }

  name           = "${each.value.policy_name} ${data.scaleway_account_project.this.name}"
  application_id = scaleway_iam_application.this.id
  rule {
    organization_id      = each.value.is_organization_policy ? data.scaleway_account_project.this.organization_id : null
    project_ids          = each.value.is_organization_policy ? null : [data.scaleway_account_project.this.id]
    permission_set_names = each.value.permission_set_names
  }
}
