#! /usr/bin/env sh

echo '---deleteing the cloudformation stack---'
aws cloudformation delete-stack --stack-name test-kube-stack

echo '---deleting the s3 bucket---'
aws s3 rm s3://BUCKET_NAME/ --recursive

echo '---cleanup complete---'

