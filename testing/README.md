# Testing

## Setup local env
```bash
# Create .credentials with the appropriate values
source .credentials # or use direnv to auto source the file
```

## Connection test examples
- [Postgresql with python](./connect/postgresql/main.py)
- [Redis cluster with TLS with python](./connect/redis/main.py)
- [SQS with python](./connect/sqs/main.py)

## Load test examples
- [Load test app by adding many messages on SQS Queue](./load/sqs/README.md)
