#!/bin/bash

# #############################################################################
# Invoke Remote Harness CD for Specified Directory via Curl
# #############################################################################

# Validate Directory
DIRECTORY=$(echo "$1" | tr '[:upper:]' '[:lower:]')
if [ -z "$DIRECTORY" ] || ([ "$DIRECTORY" != "subscription-bootstrap" ] &&  [ "$DIRECTORY" != "network" ] && [ "$DIRECTORY" != "aks-cluster" ] && [ "$DIRECTORY" != "aks-service" ] && [ "$DIRECTORY" != "azure-function-api" ] && [ "$DIRECTORY" != "static-website" ]); then
  echo "The first argument must be one of the following: subscription-bootstrap, network, aks-cluster, aks-service, azure-function-api, static-website."
  exit 2
fi

# Setup Environment
SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
if [ -f "$SCRIPT_DIRECTORY/env.sh" ]; then
  . $SCRIPT_DIRECTORY/env.sh
else
  echo "*** Variable Initialization Script Missing ***"
  echo "Follow the instructions in the env.template.sh file in the _local_only directory."
  exit 1
fi

if [ "$DIRECTORY" = "subscription-bootstrap" ]; then
  curl -X POST -H 'content-type: application/json' --url https://app.harness.io/gateway/api/webhooks/tqTQ9eX5NedclM8izL7SnPwmLCTDFSSWvXpEP2fQ?accountId=6SNoU9GISj6dV8B3Ie5QvA -d "{\"application\":\"lrMnPXeHTBuVt5-2kZtBYQ\",\"parameters\":{\"ARM_SUBSCRIPTION_ID\":\"$ARM_SUBSCRIPTION_ID\",\"ARM_TENANT_ID\":\"$ARM_TENANT_ID\",\"ARM_CLIENT_ID\":\"$ARM_CLIENT_ID\",\"ARM_CLIENT_SECRET\":\"$ARM_CLIENT_SECRET\"}}"
else
  echo "Directory not currently supported: $DIRECTORY"
fi
