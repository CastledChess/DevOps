# Organization

## 1. Deploy the organization

```bash
cd ./environments/organization/0_tfstate
terraform init
terraform apply

cd ../environments/organization/1_projects
terraform init
terraform apply

cd ../environments/organization/2_iam
terraform init
terraform apply
```
