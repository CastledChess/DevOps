output "databases" {
  value = module.database
}

output "redis_clusters" {
  value = module.redis
}

output "sqs_queues" {
  value = module.sqs_queues
}

output "buckets" {
  value = module.buckets
}

output "buckets_creds" {
  value = module.bucket_iam_app
}
