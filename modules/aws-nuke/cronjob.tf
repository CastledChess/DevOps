resource "kubernetes_manifest" "aws_nuke_cronjob" {
  provider = kubernetes

  depends_on = [kubernetes_namespace.aws_nuke_namespace]

  manifest = {
    apiVersion = "batch/v1"
    kind       = "CronJob"
    metadata = {
      name      = "aws-nuke-cronjob"
      namespace = var.namespace
    }
    spec = {
      schedule = var.cron_schedule
      jobTemplate = {
        spec = {
          template = {
            spec = {
              restartPolicy = "OnFailure"

              containers = [
                for account, _ in var.aws_accounts :
                {
                  name    = "aws-nuke-${account}"
                  image   = "rebuy/aws-nuke"
                  command = ["sh"]
                  args    = ["-c", "echo '${account}' | aws-nuke -c /config/nuke-config.yml --no-dry-run --force"]
                  env = [
                    {
                      name = "AWS_ACCESS_KEY_ID"
                      valueFrom = {
                        secretKeyRef = {
                          name = "aws-nuke-credentials"
                          key  = "${account}-key-id"
                        }
                      }
                    },
                    {
                      name = "AWS_SECRET_ACCESS_KEY"
                      valueFrom = {
                        secretKeyRef = {
                          name = "aws-nuke-credentials"
                          key  = "${account}-access-key"
                        }
                      }
                    }
                  ]
                  volumeMounts = [
                    {
                      name      = "config-volume-${account}"
                      mountPath = "/config"
                    }
                  ]
                }
              ]

              volumes = [
                for account, _ in var.aws_accounts :
                {
                  name = "config-volume-${account}"
                  configMap = {
                    name = "aws-nuke-config-${account}"
                  }
                }
              ]
            }
          }
        }
      }
    }
  }
}
