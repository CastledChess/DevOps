import os
import sys
import boto3

bucket_name = sys.argv[1]
object_key = "test_object.txt"
file_content = "Hello, S3!"

scw_access_key = os.getenv("SCW_ACCESS_KEY")
scw_secret_key = os.getenv("SCW_SECRET_KEY")
scw_region_name = os.getenv("SCW_REGION", "fr-par")
scw_endpoint_url = os.getenv("SCW_ENDPOINT_URL", "https://s3.fr-par.scw.cloud")

s3 = boto3.client(
    "s3",
    region_name=scw_region_name,
    endpoint_url=scw_endpoint_url,
    aws_access_key_id=scw_access_key,
    aws_secret_access_key=scw_secret_key,
)

# Put object
s3.put_object(Bucket=bucket_name, Key=object_key, Body=file_content)
print("Object has been uploaded successfully.")

# Get object
response = s3.get_object(Bucket=bucket_name, Key=object_key)
content = response["Body"].read().decode("utf-8")
print(f"Object content: {content}")

# Delete object
s3.delete_object(Bucket=bucket_name, Key=object_key)
print("Object has been deleted successfully.")
