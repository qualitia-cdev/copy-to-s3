#!/bin/bash -eu

echo "Initialize local valuables"

export AWS_ACCESS_KEY_ID=$1
export AWS_SECRET_ACCESS_KEY=$2
export AWS_DEFAULT_REGION=$3
readonly SOURCE_DIR=$4
readonly SERVICE_NAME=$5
readonly TARGET_DIR=$6

readonly user_id=$(aws sts get-caller-identity | jq -r '.Account')
readonly s3_dir="s3://${SERVICE_NAME}-${user_id}/${TARGET_DIR}"

echo "[Show valuables]"
echo "AWS_DEFAULT_REGION: ${AWS_DEFAULT_REGION}"
echo "user_id: ${user_id}"
echo "s3_dir: ${s3_dir}"
echo "SOURCE_DIR: ${SOURCE_DIR}"
echo "SERVICE_NAME: ${SERVICE_NAME}"
echo "TARGET_DIR: ${TARGET_DIR}"

echo "[Show contents of ${SOURCE_DIR}]"

ls ${SOURCE_DIR}

echo "[Start copying ${SOURCE_DIR} to ${s3_dir}]"

aws s3 cp ${SOURCE_DIR} ${s3_dir} --recursive

echo "::set-output name=s3dir::$s3_dir"

echo "Complete!!"