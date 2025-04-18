# Terraform Backend configuration

First, note down the following variables:

- `BUCKET` being the name of the bucket containing the different Terraform states (i.e. `<org>-<env>-tfstate`)
- `ORG` being the ID of the Scaleway organization, it should be in the `.credentials` file already
- `PROJECT` being the ID of the Scaleway project, it should be in the `.credentials` file already

Do the following step for each environment, we will take `prod` as an example.

- In `./environments/prod/0_tfstate/main.tf`, set the `bucket_name` to the `BUCKET` variable value.

- In each folder in `./environments/prod` (but `0_tfstate` that we just did), do:
  - Modify `backend.tf`, especially the `bucket` variable to put the `BUCKET` value inside
  - Modify `providers.tf` to update the `organization_id` and `project_id` values accordingly to the variables noted above
