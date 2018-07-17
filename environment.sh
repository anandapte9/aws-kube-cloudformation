#!/usr/bin/env sh

regions="us-east-2 us-east-1 us-west-1 us-west-2 ap-northeast-1 ap-northeast-2 ap-northeast-3 ap-south-1 ap-southeast-1 ap-southeast-2 ca-central-1 cn-north-1 cn-northwest-1 eu-central-1"

echo '---- Setup Environment Variables ----'
echo 'Enter a name for your S3 Bucket..(non-blank)'
while [[ -z "$BUCKET_NAME" ]]
do
   read BUCKET_NAME
done;

echo 'Enter the region you are configuring your stack in (same region your AWS CLI is configred to..)'
read REGION

match=$(echo "${regions[@]:0}" | grep -o $REGION)
[[ -z $match ]] && REGION="ap-southeast-2"

sed 's/BUCKET_NAME/'$BUCKET_NAME'/g' parameters/parameters-example.json > parameters/parameters.json
sed 's/BUCKET_NAME/'$BUCKET_NAME'/g' commands/commands.txt > commands.txt
sed 's/ap-southeast-2/'$REGION'/g' commands/commands.txt > commands.txt

echo '----- Generating ssh keys -----'
ssh-keygen -t rsa -C . -f kubekey -N ''
echo '---Uploading ssh keys to your AWS account----'
aws ec2 import-key-pair --key-name kubekey --public-key-material file://kubekey.pub

echo '----setting up S3 Bucket and uploading objects ---'
aws s3api create-bucket --bucket $BUCKET_NAME --acl public-read --region $REGION --create-bucket-configuration LocationConstraint=$REGION
aws s3 sync files/ s3://$BUCKET_NAME/
aws s3api put-object --bucket $BUCKET_NAME --key kubekey --body kubekey --region $REGION
aws s3api put-object-acl --bucket $BUCKET_NAME --key amilookup.zip --acl public-read
aws s3api put-object-acl --bucket $BUCKET_NAME --key master/kube-configure.sh --acl public-read
aws s3api put-object-acl --bucket $BUCKET_NAME --key nodes/kube-configure.sh --acl public-read
aws s3api put-object-acl --bucket $BUCKET_NAME --key kubekey --acl public-read

echo '---Creating cloudformation stack ---'
aws cloudformation create-stack --stack-name test-kube-stack --template-body file://kube.yaml --parameters file://parameters/parameters.json --capabilities CAPABILITY_IAM

while aws cloudformation describe-stack --stack-name test-kube-stack | grep -m 1 "CREATE_COMPLETE"
do
sleep 60;
aws cloudformation describe-stack --stack-name test-kube-stack;
done
