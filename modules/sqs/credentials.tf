module "creds" {
  source = "../scw_secret"

  name = "sqs-credentials"
  data = merge(
    {
      admin = {
        access_key = scaleway_mnq_sqs_credentials.admin.access_key
        secret_key = scaleway_mnq_sqs_credentials.admin.secret_key
      }
    },
    {
      for k, v in scaleway_mnq_sqs_credentials.apps :
      k => {
        access_key = v.access_key
        secret_key = v.secret_key
      }
    }
  )
}
