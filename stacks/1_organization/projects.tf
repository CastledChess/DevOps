resource "scaleway_account_project" "projects" {
  for_each = toset(var.project_names)
  name     = title(each.value)
}
