# How to connect to a Kubernetes cluster

To get the Kubeconfig to access the Kubernetes clusters, follow these steps:

- Navigate to [Scaleway K8s' page](https://console.scaleway.com/kubernetes/clusters)
- (Choose the project you want on the top bar)
- Click on the cluster (e.g. `equisafe-prod`)
- Download the Kubeconfig, bottom-right panel
- Move it to this folder, and save it under `.kubeconfig/kubeconfig.<env>` (e.g. `kubeconfig.prod`)

To use this Kubeconfig with `kubectl`, run:

- `export KUBECONFIG=$(pwd)/.kubeconfig/kubeconfig.prod`
- `kubectl get namespaces`: this should list the different namespaces.
