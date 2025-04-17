resource "scaleway_registry_namespace" "this" {
  for_each = var.scaleway_repository_registries

  name        = each.value.name
  description = each.value.description
  is_public   = each.value.is_public
  region      = each.value.region
  project_id  = each.value.project_id
}
