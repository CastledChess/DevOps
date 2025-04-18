# How to connect to a PostgreSQL database

## Prerequisites

- `kubectl` and [a Kubeconfig file](../kubernetes/connect_cluster.md)
- `secenv` and working API keys ([related docs](../secrets/secenv.md))

## Usage

```sh
cd environments/<env>
# Get PostgreSQL credentials
secenv context get database  # copy the output

# Create a PostgreSQL pod in the Kubernetes cluster and get inside it
kubectl run --rm -it --image=postgres postgresql-connector -- bash

# Load database credentials
# paste `secenv` outputs
# and avoid typing the DB password
export PGPASSWORD=$DB_PASSWORD

# Connect to the database
psql -h $DB_HOST -p $DB_PORT -U $DB_USERNAME -d <db name : db>
```

Now, it's possible to run SQL queries:

```sql
\list
\dt
```

Once done, exit the pod to delete it.
