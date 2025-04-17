import os
import sys
import uuid
import boto3
import json
import threading


queue_name = sys.argv[1]  # Possible values : gpu-tasks-queue, cpu-tasks-queue, task-updates-queue

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


MAX_NUMBER_OF_MESSAGE_PER_RAW = 10


def process_messages(messages):
    threads = []
    for message in messages:
        # Create a thread for each message
        thread = threading.Thread(target=process_message, args=(message,))
        threads.append(thread)
        thread.start()

    # Wait for all threads to complete
    for thread in threads:
        thread.join()


def process_message(message):
    process_id = str(uuid.uuid4())
    message_body = json.loads(message['Body'])

    print(f"{process_id} | Processing message: {message_body['message']}")
    receipt_handle = message['ReceiptHandle']
    sqs.delete_message(
        QueueUrl=queue_url,
        ReceiptHandle=receipt_handle
    )


def clear_queue():
    while True:
        try:
            # Receive multiple messages from SQS queue
            response = sqs.receive_message(
                QueueUrl=queue_url,
                AttributeNames=['All'],
                MessageAttributeNames=['All'],
                MaxNumberOfMessages=MAX_NUMBER_OF_MESSAGE_PER_RAW,
                VisibilityTimeout=0,
                WaitTimeSeconds=0
            )

            messages = response.get('Messages', [])
            if messages:
                # Process the messages concurrently
                process_messages(messages)
        except Exception as e:
            print(f"Error: {e}")


if __name__ == "__main__":
    clear_queue()
