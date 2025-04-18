# How to restart a pod in a Kubernetes cluster

## Prerequisites

- `kubectl` and [a Kubeconfig file](./connect_cluster.md)

## Usage

```sh
# List namespaces
kubectl get namespaces

# List pods
kubectl get pods -n $NAMESPACE

# Restart a pod
kubectl restart -n $NAMESPACE $POD
```
