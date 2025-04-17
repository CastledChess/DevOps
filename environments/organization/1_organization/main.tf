module "organization" {
  source        = "../../../stacks/1_organization"
  project_names = ["production", "mock"]

  # iam_groups = {
  #   "Keltio Administrators" = {
  #     description = "Admin group for Keltio Energy"
  #     policies = [
  #       {
  #         permission_set = "OrganizationManager"
  #         scope_type     = "organization"
  #       },
  #       {
  #         permission_set = "AllProductsFullAccess"
  #         scope_type     = "organization"
  #       }
  #     ]
  #   }
  #   "Keltio Billing" = {
  #     policies = [
  #       {
  #         permission_set = "BillingManager"
  #         scope_type     = "organization"
  #       }
  #     ]
  #   },
  #   "Keltio Developers" = {
  #     policies = [
  #       {
  #         permission_set = "AllProductsReadOnly"
  #         scope_type     = "organization"
  #       }
  #     ]
  #   }
  # }

  # iam_users = {
  #   "victor@keltio.fr" = ["Keltio Administrators", "Keltio Billing"]
  # }
}
