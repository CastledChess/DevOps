# How to connect to a Kubernetes cluster

## Prerequisites

- `terraform` and working API keys

## Usage

```sh
# Go to desired environment
cd ./environments/$ENV/1_infra

# Get Terraform outputs
terraform init
terraform output --raw kubernetes_kubeconfig >> kubeconfig
```

At this stage, move the `kubeconfig` to a safe place as it's a secret.
An example could be `.kubeconfig/kubeconfig.$ENV`.

Now use it by running:

```sh
export KUBECONFIG=/path/to/kubeconfig.$ENV
kubectl get namespaces
```
