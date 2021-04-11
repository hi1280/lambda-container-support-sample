#!/bin/sh -e

function usage {
    cat <<EOF
$(basename ${0}) is a script for docker image build

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

docker build -t $ACCOUNT_ID.dkr.ecr.ap-northeast-1.amazonaws.com/lambda-container-support-sample:$VERSION .
aws ecr create-repository --repository-name lambda-container-support-sample || true
aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.ap-northeast-1.amazonaws.com
docker tag $ACCOUNT_ID.dkr.ecr.ap-northeast-1.amazonaws.com/lambda-container-support-sample:$VERSION $ACCOUNT_ID.dkr.ecr.ap-northeast-1.amazonaws.com/lambda-container-support-sample:latest
docker push $ACCOUNT_ID.dkr.ecr.ap-northeast-1.amazonaws.com/lambda-container-support-sample:$VERSION
docker push $ACCOUNT_ID.dkr.ecr.ap-northeast-1.amazonaws.com/lambda-container-support-sample:latest