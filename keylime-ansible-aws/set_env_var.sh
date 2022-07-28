#!/bin/bash
usage() {
        echo "Usage: ./set_env_var.sh <AWS access key ID> <AWS secret key> <AWS region>"
}
if [[ ($# -ne 2) || ($@ == "--help") || ($@ == "-h") ]]
then
        usage
        exit 1
fi
export AWS_ACCESS_KEY="$1"
echo "AWS_ACCESS_KEY is set to $AWS_ACCESS_KEY"
export AWS_SECRET_KEY="$2"
echo "AWS_SECRET_KEY is set to $AWS_SECRET_KEY"
export AWS_REGION="$3"
echo "AWS_REGION is set to $AWS_REGION"
$SHELL
