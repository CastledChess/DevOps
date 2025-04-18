# How to connect to a managed Redis database

## Prerequisites

- `kubectl` and [a Kubeconfig file](../kubernetes/connect_cluster.md)
- `secenv` and working API keys ([related docs](../secrets/secenv.md))

## Usage

```sh
# Get Redis credentials
secenv context redis  # copy the output

# Create a Redis pod in the Kubernetes cluster and get inside it
kubectl run --rm -it --image=redis redis-connector -- bash

# Load Redis credentials
# paste `secenv` outputs

# Connect to the Redis
redis-cli -u "redis://$REDIS_PASSWORD@$REDIS_HOST:$REDIS_PORT"
```

Now, it's possible to run Redis queries:

```
SET myKey "Hello"
GET myKey
```

Once done, exit the pod to delete it.
