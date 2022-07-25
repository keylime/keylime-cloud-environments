#!/bin/bash
usage() {
	echo "Warning: this script parses the GCP service account credential file for the email and project ID."
        echo "Usage: ./set_env_var.sh <path to JSON cred file> <GCP region> <GCP zone>"
}
if [[ ($# -ne 3) || ($@ == "--help") || ($@ == "-h") ]]
then
        usage
        exit 1
fi
echo "Warning: this script parses the GCP service account credential file for the email and project ID."
sleep 5
export GCP_REGION="$2"
echo "GCP REGION is set to $GCP_REGION"
export GCP_ZONE="$3"
echo "GCP ZONE is set to $GCP_ZONE"
export GCP_CRED_FILE="$1"
echo "GCP CRED FILE is set to $GCP_CRED_FILE"
export GCP_PROJECT="$(sed -e 's/^"//' -e 's/"$//' <<< "$(jq .project_id $1)")"
echo "GCP PROJECT is set to $GCP_PROJECT"
export GCP_CRED_KIND="serviceaccount"
echo "GCP CRED KIND is set to $GCP_CRED_KIND"
export GCP_CRED_EMAIL="$(sed -e 's/^"//' -e 's/"$//' <<< "$(jq .client_email $1)")"
echo "GCP CRED EMAIL is set to $GCP_CRED_EMAIL"
echo "Launching shell with environment variables"
$SHELL
