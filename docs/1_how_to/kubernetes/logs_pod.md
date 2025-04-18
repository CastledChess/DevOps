# How to read logs of a pod in a Kubernetes cluster

## Prerequisites

- `kubectl` and [a Kubeconfig file](./connect_cluster.md)

## Usage

```sh
# List namespaces
kubectl get namespaces

# List pods
kubectl get pods -n $NAMESPACE

# Read logs of a pod
kubectl logs -fn $NAMESPACE $POD
```
