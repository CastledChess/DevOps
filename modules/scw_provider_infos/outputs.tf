output "organization_id" {
  value = data.scaleway_account_project.this.organization_id
}

output "project_id" {
  value = data.scaleway_account_project.this.id
}

output "project_name" {
  value = data.scaleway_account_project.this.name
}

output "region" {
  value = data.scaleway_vpc.default.region
}
