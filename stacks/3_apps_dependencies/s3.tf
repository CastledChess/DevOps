module "s3_access" {
  count = var.should_create_s3_access ? 1 : 0

  source = "../../modules/iam_app"

  name = "${local.app_name} - Object Storage access"
  policies = [
    {
      policy_name          = "${local.app_name} ObjectStorageFullAccess"
      permission_set_names = ["ObjectStorageFullAccess"]
    }
  ]
}

module "s3_buckets" {
  for_each = var.scaleway_buckets

  source = "../../modules/scw_bucket"

  name            = each.key
  acl             = each.value.acl
  region          = each.value.region
  tags            = each.value.tags
  lifecycle_rules = each.value.lifecycle_rules
}
