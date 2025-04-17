import os
from rediscluster import RedisCluster

redis_host = os.getenv("REDIS_HOST")
redis_port = int(os.getenv("REDIS_PORT", "6379"))
redis_username = os.getenv("REDIS_USERNAME")
redis_password = os.getenv("REDIS_PASSWORD")
use_tls = os.getenv("REDIS_USE_TLS", "true").lower() in ["true", "1", "yes"]
redis_cacert = os.getenv(
    "REDIS_CACERT", "SSL_redis-mock.pem"
)  # Specify the certificate path if needed

startup_nodes = [{"host": redis_host, "port": redis_port}]

if use_tls:
    rc = RedisCluster(
        startup_nodes=startup_nodes,
        decode_responses=True,
        username=redis_username,
        password=redis_password,
        ssl=True,
        ssl_cert_reqs=None,  # Pour désactiver la vérification du certificat, à configurer selon vos besoins
        ssl_ca_certs=redis_cacert,  # Specify the CA certificate path if needed
        skip_full_coverage_check=True,  # Skip full coverage check
    )
else:
    rc = RedisCluster(
        startup_nodes=startup_nodes,
        decode_responses=True,
        username=redis_username,
        password=redis_password,
        skip_full_coverage_check=True,  # Skip full coverage check
    )

rc.set("test_key", "Hello, Redis!")
value = rc.get("test_key")
print(f"Value for 'test_key': {value}")
