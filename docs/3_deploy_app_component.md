# Deploy an app component


## 1. Create a secret on the Scaleway Secret Manager with the component Data

In order to work properly, apps need environment variables and sometimes files exposed during runtime.

These configurations are exposed in two ways:

For infrastructure data (e.g., DB_HOST, REDIS_CERT, etc.), the configurations are exposed via secrets and volumes defined in Terraform.
For app-specific data (e.g., SENTRY_DSN, etc.), the configurations are exposed via secrets synchronized with the Scaleway Secret Manager.

**Note:** : Ensure not to include infrastructure data in the app secrets as they will already be present in the infrastructure secrets, which may cause connection problems.

## 2. Create a Terraform component folder

At this point, the infrastructure should contain -at least- a configured Kubernetes cluster with components inside.

To deploy a new component, duplicate an existing application folder (e.g : `frugalia`), then edit `./environments/prod/3_apps/<app name>/providers.tf:scaleway_k8s_cluster.this` to use the cluster defined in the previous step.

Now edit all the files in the folder to matching target for the app.

**Note :** Make sur to not include apps data on the secret as it may change a lot and will be easier for devs to update it on the Secret Manager


## 3. Deploy the component and its dependencies

It is now time to deploy the applications as Kubernetes manifests.
The `prod-apps` module handles the creation of the Scaleway Docker registries, as well as ArgoCD configuration to access both the registries and the Git repositories.

```bash
# Deploy the dependencies (if exists)
cd ./environments/prod/3_apps/
terraform init
terraform apply

# Deploy the app
cd ./environments/prod/3_apps/<app name>
terraform init
terraform apply
```

## FAQ

### How to add or update an environment variable for a component ?

Navigate to the Secret Manager service on the Scaleway Console and edit the component's secret with the appropriate values.

Be careful; the secret must be valid JSON.

Once updated, the External Secret service in Kubernetes will synchronize the secret to the Kubernetes cluster, and Reloader will automatically restart the app.

This automatic refresh and restart process can take up to 10-15 minutes.

Here is a schema explaning how the environment variable update works :
