#!/bin/sh -e

function usage {
    cat <<EOF
$(basename ${0}) is a script for deploy lambda function

Usage:
    $(basename ${0}) <AWS AccountId>

Example:
    $(basename ${0}) 123456789012
EOF
}

if [ $# -ne 1 ]; then
  usage
  exit 1
fi

ACCOUNT_ID=$1
VERSION=`git rev-parse --short HEAD`

aws lambda update-function-code --function-name lambda-container-support-sample --image-uri $ACCOUNT_ID.dkr.ecr.ap-northeast-1.amazonaws.com/lambda-container-support-sample:$VERSION --publish