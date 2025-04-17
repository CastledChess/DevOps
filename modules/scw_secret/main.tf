resource "scaleway_secret" "this" {
  name        = var.name
  path        = var.path
  description = var.description
  tags        = var.tags
}

locals {
  data = try(
    tostring(var.data), # if fails if this is not an object
    jsonencode(var.data),
  )
}

resource "scaleway_secret_version" "this" {
  secret_id = scaleway_secret.this.id

  data = local.data
}
