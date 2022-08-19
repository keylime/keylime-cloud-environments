#!/bin/bash
usage() {
        echo "Usage: ./set_env_var.sh <path to AWS key .csv> <AWS region>"
}
if [[ ($# -ne 2) || ($@ == "--help") || ($@ == "-h") ]]
then
        usage
        exit 1
fi
export AWS_REGION="$2"
echo "AWS_REGION is set to $AWS_REGION"
while IFS=, read -r id key
do 
	export AWS_ACCESS_KEY="$id"
	export AWS_SECRET_KEY="$key"
done < $1
echo "AWS_ACCESS_KEY is set to $AWS_ACCESS_KEY"
echo "AWS_SECRET_KEY is set to $AWS_SECRET_KEY"
$SHELL
