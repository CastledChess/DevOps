# How to migrate folder to S3 Scaleway Bucket

```bash
# Make sur to export all Scaleway env vars with AWS Format like so :
# export AWS_ACCESS_KEY_ID=$SCW_ACCESS_KEY
# export AWS_SECRET_ACCESS_KEY=$SCW_SECRET_KEY
# export AWS_DEFAULT_REGION=$SCW_DEFAULT_REGION

PATH_TO_FOLDER_TO_MIGRATE=/storage-castledchess/storage
SCALEWAY_S3_BUCKET_NAME=castledchess-laravel-assets-prod

aws s3 --endpoint-url "https://s3.$SCW_DEFAULT_REGION.scw.cloud" sync $PATH_TO_FOLDER_TO_MIGRATE "s3://$SCALEWAY_S3_BUCKET_NAME"
```

**Note :** You can make a cron to sync periodicly the folder to the destination S3. Like this you will not have to rerun the command every time you want to make a check before the final migration
