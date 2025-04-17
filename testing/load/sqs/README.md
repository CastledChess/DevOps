# Load test app by adding many message on SQS Queue

## Send fake requests to functions

```bash
python send_message_to_queue.py <queue-name> <message-count>
# Examples :
# python send_message_to_queue.py gpu-tasks-queue 1000
# python send_message_to_queue.py cpu-tasks-queue 1000
# python send_message_to_queue.py task-updates-queue 1000
```

## Clear queue after tests
```bash
python clear_queue.py <queue-name>
# Examples :
# python clear_queue.py gpu-tasks-queue
# python clear_queue.py cpu-tasks-queue
# python clear_queue.py task-updates-queue
```


## To know

- 4min to create a new Kubernetes node


- 6min to pull the GPU docker image on a new node
- 3min30 to pull the CPU docker image on a new node
