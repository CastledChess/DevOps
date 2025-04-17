import os
import sys
import boto3
import json
import random


NUMBER_OF_THREADS = 10

queue_name = sys.argv[1]  # Possible values : mock
number_of_message_to_send = int(sys.argv[2])

scw_access_key = os.getenv("SCW_ACCESS_KEY")
scw_secret_key = os.getenv("SCW_SECRET_KEY")
scw_region_name = os.getenv("SCW_REGION", "fr-par")
scw_endpoint_url = os.getenv("SCW_ENDPOINT_URL", "https://sqs.mnq.fr-par.scaleway.com")
queue_url = os.getenv("QUEUE_URL") + queue_name


sqs = boto3.client(
    "sqs",
    region_name=scw_region_name,
    endpoint_url=scw_endpoint_url,
    aws_access_key_id=scw_access_key,
    aws_secret_access_key=scw_secret_key,
)


def publish_message(queue_url):
    for i in range(round(number_of_message_to_send / NUMBER_OF_THREADS)):
        # Message to be published
        message_body = {
            "message": "Hello, SQS!",
            "time_to_run": random.randint(10, 30),
            "function": "Super function ;)",
        }

        # Publish the message to the queue
        response = sqs.send_message(
            QueueUrl=queue_url, MessageBody=json.dumps(message_body)
        )

        print(
            f"Message published to SQS queue {queue_url.split('/')[-1]} with MessageId: {response['MessageId']}"
        )


def process_message(message):
    message_body = message["Body"]
    print(f"Raw message body: {message_body}")

    try:
        message_body = json.loads(message_body)
        print(f"Processing message: {message_body}")

        if "function" in message_body:
            print(f"Executing function: {message_body['function']}")
        else:
            print("No function found in message.")
    except json.JSONDecodeError:
        print("Message is not in JSON format.")


def read_message(queue_url):
    response = sqs.receive_message(
        QueueUrl=queue_url, MaxNumberOfMessages=10, WaitTimeSeconds=10
    )

    messages = response.get("Messages", [])
    if messages:
        for message in messages:
            print(f"Received message: {message['Body']}")
            process_message(message)
            sqs.delete_message(
                QueueUrl=queue_url, ReceiptHandle=message["ReceiptHandle"]
            )
            print(f"Message deleted: {message['MessageId']}")
    else:
        print("No messages to read.")


publish_message(queue_url)
print("Test message has been published successfully.")

read_message(queue_url)
print("Test message has been read successfully.")
