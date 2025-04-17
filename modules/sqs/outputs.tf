output "queues" {
  value = {
    for k, v in scaleway_mnq_sqs_queue.self :
    k => {
      endpoint = v.sqs_endpoint
      url      = v.url
    }
  }
}
