import os
import sys
import boto3
import json
import random
import threading


NUMBER_OF_THREADS = 10

queue_name = sys.argv[1] # Possible values : gpu-tasks-queue, cpu-tasks-queue, task-updates-queue
number_of_message_to_send = int(sys.argv[2])

scw_access_key = os.getenv('SCW_ACCESS_KEY')
scw_secret_key = os.getenv('SCW_SECRET_KEY')
scw_region_name = os.getenv('SCW_REGION', 'fr-par')
scw_endpoint_url = os.getenv('SCW_ENDPOINT_URL', 'https://sqs.mnq.fr-par.scaleway.com')
queue_url = os.getenv("QUEUE_URL") + queue_name


sqs = boto3.client(
    'sqs',
    region_name=scw_region_name,
    endpoint_url=scw_endpoint_url,
    aws_access_key_id=scw_access_key,
    aws_secret_access_key=scw_secret_key
)

# Define function to publish message


def publish_message(queue_url):
    for i in range(round(number_of_message_to_send / NUMBER_OF_THREADS)):
        # Message to be published
        message_body = {
            "message": "Hello, SQS!",
            "time_to_run": random.randint(10, 30),
            'function': "Super function ;)"
        }

        # Publish the message to the queue
        response = sqs.send_message(
            QueueUrl=queue_url,
            MessageBody=json.dumps(message_body)
        )

        print(f"Message published to SQS queue {queue_url.split('/')[-1]} with MessageId: {response['MessageId']}")


# Create and start threads
threads = []
for _ in range(NUMBER_OF_THREADS):
    thread = threading.Thread(target=publish_message, args=(queue_url,))
    threads.append(thread)
    thread.start()

# Wait for all threads to complete
for thread in threads:
    thread.join()

print("All messages published successfully.")
