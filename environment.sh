#!/usr/bin/env sh

echo 'Enter a name for your S3 Bucket..'
read BUCKET_NAME

echo 'Enter the region you are cnfiguring your stack in (same region your AWS CLI is configred to..)'
read REGION

sed 's/BUCKET_NAME/'$BUCKET_NAME'/g' parameters/parameters-example0.json > parameters.json
sed 's/BUCKET_NAME/'$BUCKET_NAME'/g' commands/commands.txt > commands.txt
sed 's/ap-southeast-2/'$REGION'/g' commands/commands.txt > commands.txt
