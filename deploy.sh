#!/bin/bash

sam package --s3-bucket $1 --output-template-file packaged.yaml

sam deploy --template-file packaged.yaml --region us-east-1 --capabilities CAPABILITY_IAM --stack-name $2 --parameter-overrides Bucket=$1 ProjectName=$2 Environment=$3 Version=$4
