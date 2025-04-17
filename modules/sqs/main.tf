resource "scaleway_mnq_sqs" "self" {}

resource "scaleway_mnq_sqs_credentials" "admin" {
  project_id = scaleway_mnq_sqs.self.project_id
  name       = "admin"

  permissions {
    can_manage  = true
    can_receive = false
    can_publish = false
  }
}

resource "scaleway_mnq_sqs_queue" "self" {
  for_each = var.queues

  project_id   = scaleway_mnq_sqs.self.project_id
  name         = each.key
  sqs_endpoint = scaleway_mnq_sqs.self.endpoint
  access_key   = scaleway_mnq_sqs_credentials.admin.access_key
  secret_key   = scaleway_mnq_sqs_credentials.admin.secret_key
}

resource "scaleway_mnq_sqs_credentials" "apps" {
  for_each = var.creds

  project_id = scaleway_mnq_sqs.self.project_id
  name       = each.key

  permissions {
    can_manage  = each.value.can_manage
    can_receive = each.value.can_receive
    can_publish = each.value.can_publish
  }
}
