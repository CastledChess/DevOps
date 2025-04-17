resource "scaleway_iam_user" "this" {
  email = var.email
}

resource "scaleway_iam_group_membership" "this" {
  for_each = toset(var.groups)

  group_id = each.key
  user_id  = scaleway_iam_user.this.id
}
