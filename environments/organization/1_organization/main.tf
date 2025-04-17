module "organization" {
  source        = "../../../stacks/1_organization"
  project_names = ["production", "mock"]

  # iam_groups = {
  #   "CastledChess Administrators" = {
  #     description = "Admin group for CastledChess"
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
  #   "CastledChess Billing" = {
  #     policies = [
  #       {
  #         permission_set = "BillingManager"
  #         scope_type     = "organization"
  #       }
  #     ]
  #   },
  #   "CastledChess Developers" = {
  #     policies = [
  #       {
  #         permission_set = "AllProductsReadOnly"
  #         scope_type     = "organization"
  #       }
  #     ]
  #   }
  # }

#   iam_users = {
#     "oualid.zejli@epitech.eu"       = ["CastledChess Administrators", "CastledChess Billing"],
#     "idriss.nait-chalal@epitech.eu" = ["CastledChess Administrators", "CastledChess Billing"]
#   }
}
