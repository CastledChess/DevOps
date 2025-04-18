# How to migrate Mysql database to Scaleway instance

## 1) Expose temporary the Scaleway private db instance publicly
```bash
export DB_HOST="<put the scaleway db instance ip>"
export DB_PORT="<put the scaleway db instance port>"

cat << EOF > expose-db.yaml
apiVersion: v1
kind: Endpoints
metadata:
  name: mysql-migration
subsets:
  - addresses:
      - ip: $DB_HOST
    ports:
      - port: $DB_PORT
        protocol: TCP
---
apiVersion: v1
kind: Service
metadata:
  name: mysql-migration
spec:
  type: LoadBalancer
  ports:
    - port: $DB_PORT
      targetPort: $DB_PORT
      protocol: TCP
EOF
kubectl apply -f expose-db.yaml
```

## 2) Dump the current production
```bash
# Dump schemas
mysqldump -h $DB_HOST -P $DB_PORT -u $DB_USERNAME --add-drop-table --no-data <production database name> --single-transaction --set-gtid-purged=OFF > sql_schema.sql

# Dump data
mysqldump -h $DB_HOST -P $DB_PORT -u $DB_USERNAME --no-create-info <production database name> --single-transaction --set-gtid-purged=OFF > sql_data.sql
```

## 3) Import data to new Scaleway production database
```bash
# Remove DEFINER as Scaleway doesn't support it
sed -Ei 's/DEFINER=[`"].*[`"]@[`"]%[`"] //g' sql_schema.sql

# Load schemas (no log means it's OK)
mysql -h $DB_HOST -P $DB_PORT -u $DB_USERNAME laravel < sql_schema.sql

# Load data (no log means it's OK)
mysql -h $DB_HOST -P $DB_PORT -u $DB_USERNAME laravel < sql_data.sql
```

## 4) Put the db instance back to private
```bash
kubectl delete -f expose-db.yaml
```
