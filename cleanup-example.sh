#! /usr/bin/env sh

echo 'Deleteing the cloudformation stack...'
aws cloudformation delete-stack --stack-name test-kube-stack

echo 'Deleting the s3 bucket and contents...'
aws s3 rm s3://BUCKET_NAME/ --recursive

echo 'Deleting key-pair...'
aws ec2 delete-key-pair --key-name kubekey

echo 'Deleting local temporary files...'
rm -f parameters/parameters.json
rm -f kubekey
rm -f kubekey.pub

echo '---cleanup complete---'
