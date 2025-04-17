data "scaleway_account_project" "this" {}

# Trick here is to use a always-present resource
# so we can grab it's region
data "scaleway_vpc" "default" {
  is_default = true
}
