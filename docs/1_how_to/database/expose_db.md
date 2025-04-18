# How to expose Database

```bash
cd environments/<env>
kubectl apply -f ../../scripts/database/expose-$ENV-db.yaml

kubectl get svc -n default lucidia-db
# result show look like this :
NAME         TYPE           CLUSTER-IP     EXTERNAL-IP      PORT(S)          AGE
lucidia-db   LoadBalancer   10.42.142.66   51.159.113.228   5432:30460/TCP   26s

# The ip to use to connect to the db is the EXTERNAL-IP
# The port to use is the one defined in the yaml file (5432 in this case)
# The username and password are the ones defined in the secrets
# Launch in terminal : secenv contexts gen database-lucidia
```

Now you can use PGAdmin to connect to the database with the external IP

**IMPORTANT**
Once you are done, do not forget to unexpose the db by running the following commands :
```bash
cd environments/<env>
kubectl delete -f ../../scripts/database/expose-$ENV-db.yaml
```
