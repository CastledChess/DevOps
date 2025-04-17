module "infra" {
  source = "../../../stacks/1_infra"

  vpc_name                 = "castledchess-prod"
  vpc_private_network_name = "castledchess-private-network"
  vpc_zones                = ["fr-par-1"]
  vpc_public_gateway_type  = "VPC-GW-S"

  databases = {
    "castledchess-outreach" = {
      name          = "castledchess-outreach"
      node_type     = "db-dev-s"
      engine        = "MySQL-8"
      is_ha_cluster = false

      db_names                  = ["kollectif_devsecops", "test_kollectif_devsecops"]
      volume_type               = "lssd"
      volume_size_in_gb         = "5"
      backup_schedule_frequency = "24"
      backup_schedule_retention = "7"
      backup_same_region        = false
      users = {
        oualid = {
          is_admin = true
          permissions = {
            "kollectif_devsecops"      = "all"
            "test_kollectif_devsecops" = "all"
          }
        }
        # "castledchess-outreach" = {
        #   name     = "castledchess-outreach"
        #   password = "castledchess-outreach"
        #   is_admin = true
        #   permissions = {
        #     "kollectif_devsecops"      = "all"
        #     "test_kollectif_devsecops" = "all"
        #   }
        # }
      }
      # settings = {
      #   max_connections = "100"
      # }
    }
  }

  kubernetes_name    = "castledchess-prod"
  kubernetes_version = "1.30"
  kubernetes_cni     = "calico"
  kubernetes_auto_upgrade = {
    enable                        = true
    maintenance_window_day        = "any"
    maintenance_window_start_hour = 1
  }
  kubernetes_pools = {
    default = {
      name                   = "default"
      node_type              = "PRO2-XS"
      size                   = 2
      min_size               = 2
      max_size               = 5
      autohealing            = true
      root_volume_size_in_gb = 100
      autohealing            = true
      autoscaling            = true
      tags                   = ["castledchess.fr/pool=default"]
    }
  }
  # by default everything not within the private network is blocked
  # kubernetes_security_group_inbound_rules = [{ ip_range = "0.0.0.0/0", port = 22 }] # to allow SSH from anywhere

  cockpit_enabled    = true
  cockpit_recipients = ["oualid.zejli@epitech.eu", "idriss.nait-chalal@epitech.eu"]
}
