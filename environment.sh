#!/usr/bin/env sh

echo 'Enter a name for your S3 Bucket..'
read BUCKET_NAME

sed 's/BUCKET_NAME/'$BUCKET_NAME'/g' parameters/parameters-example0.json > parameters.json
sed 's/BUCKET_NAME/'$BUCKET_NAME'/g' commands/commands.txt > commands.txt
