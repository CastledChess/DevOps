# Connect to Redis

## Prerequisites
- redis-cli
- kubectl

## Expose kubernetes database locally
```bash
kubectl port-forward service/api-redis-master -n consolidator-$ENV 6666:6379
```

## Get to Redis database db password

```bash
redis-cli -h 127.0.0.1 -p 6666

> AUTH <REDIS PASSWORD>
```

## Run command against redis
```sql
select * from client;
```

