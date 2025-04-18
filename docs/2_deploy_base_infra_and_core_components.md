# Infrastructure & components

## 1. Create all the infrastructure and application secrets on the Scaleway Secret Manager

Once you have [exposed the Scaleway project credentials localy](./1_setup_scaleway_credentials_on_terminal.md), you will be able to create all the secrets on Scaleway.

The secrets definition and filling are handled by [secenv](https://secenv.keltio.fr).
It reads the `.secenv.yml` file at the repository's root.

The typical required secrets are:

- Cloudflare API token to handle DNS records
- Gitlab PAT to access the private repositories (Helm charts)
- Registries credentials to access the private Docker images
- Database credentials
- ...

Once they are all configured in the SecEnv configuration file, run `secenv secrets` and fill the secrets on the Scaleway Secret Manager interactively.

Note that it's safe to re-run SecEnv with filled secrets as it will ask before overwriting anything.

## 2. Configure Infrastructure settings

To create the bare elements of the infrastructure (i.e. a Kubernetes cluster, a Postgres database, etc), edit `./environments/<env>/1_infra/main.tf`.
This file declares a `<env>_infra` module instantiating the different elements.

The `*_enabled` values are `true` by default, consider setting them to `false` individually if a module is not required (i.e. Redis).

For the databases, it is possible to declare the databases of an instance those ways:

- `database_db_name = "value"` if only one exists
- `database_db_names = ["value1", "value2"]` if several exists

In every case, the created databases is the concatenation of those values.

If a Kubernetes cluster is instantiated, note down its name as it will be required in the next steps.

## 3. Deploy the base infrastructure

```bash
cd ./environments/<env>/0_tfstate
terraform init
terraform apply

cd ../1_infra
terraform init
terraform apply
```

## 4. Configure Kubernetes core services

Once the bare elements of the infrastructure are deployed, it is time to fill the cluster and install its internal components.

In the `./environments/<env>/2_k8s_services/providers.tf`, edit the `scaleway_k8s_cluster.this` resource to use the previously created K8s cluster's name.

Once done, edit `./environments/<env>/2_k8s_services/main.tf` to setup ExternalDNS, NginxController and CertManager.

## 5. Deploy the Kubernetes core services

```bash
cd ./environments/<env>/2_k8s_services
terraform init
terraform apply
```
