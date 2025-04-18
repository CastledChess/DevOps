# How to connect to a MySQL database

## Prerequisites

- `kubectl` and [a Kubeconfig file](../kubernetes/connect_cluster.md)
- `secenv` and working API keys ([related docs](../secrets/secenv.md))

## Usage

```sh
# Get MySQL credentials
secenv context database  # copy the output

# Create a MySQL pod in the Kubernetes cluster and get inside it
kubectl run --rm -it --image=mysql mysql-connector -- bash

# Load database credentials
# paste `secenv` outputs
# and avoid typing the DB password
export MYSQL_PWD=$DB_PASSWORD

# Connect to the database
mysql -h $DB_HOST -P $DB_PORT -u $DB_USERNAME
```

Now, it's possible to run SQL queries:

```sql
use my_database;
show tables;
```

Once done, exit the pod to delete it.
