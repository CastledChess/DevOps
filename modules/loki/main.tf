resource "helm_release" "loki" {
  name = "loki"

  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki"
  version    = "6.10.2"

  namespace = "monitoring"

  values = [yamlencode({
    global = { dnsService = "coredns" }

    deploymentMode = "SingleBinary"

    loki = {
      auth_enabled = false

      commonConfig = {
        replication_factor = 1
      }
      storage = {
        type = "filesystem"
      }
      schemaConfig = {
        configs = [
          {
            from  = "2024-01-01"
            store = "tsdb"
            index = {
              prefix = "loki_index_"
              period = "24h"
            }
            object_store = "filesystem"
            schema       = "v13"
          }
        ]
      }
    }

    test       = { enabled = false }
    lokiCanary = { enabled = false }

    singleBinary = {
      replicas = 1
      persistence = {
        size         = "50Gi"
        storageClass = "scw-bssd-retain"
      }
    }
    read    = { replicas = 0 }
    backend = { replicas = 0 }
    write   = { replicas = 0 }
  })]
}
