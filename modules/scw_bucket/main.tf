module "provider_infos" {
  source = "../scw_provider_infos"
}

locals {
  region = var.region != null ? var.region : module.provider_infos.region
}

resource "scaleway_object_bucket" "this" {
  name   = var.name
  tags   = var.tags
  region = local.region

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules
    content {
      id      = lifecycle_rule.key
      enabled = lifecycle_rule.value.enabled

      dynamic "expiration" {
        for_each = lifecycle_rule.value.expiration != null ? { expiration = lifecycle_rule.value.expiration } : {}
        content {
          days = expiration.value.days
        }
      }

      dynamic "transition" {
        for_each = lifecycle_rule.value.transition != null ? { transition = lifecycle_rule.value.transition } : {}
        content {
          days          = transition.value.days
          storage_class = transition.value.storage_class
        }
      }
    }
  }
}

resource "scaleway_object_bucket_acl" "this" {
  bucket = scaleway_object_bucket.this.id
  acl    = var.acl
  region = local.region
}
