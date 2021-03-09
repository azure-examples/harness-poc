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
elif [ "$DIRECTORY" = "network" ]; then
  TF_VAR_gateway_address_space=$(echo $TF_VAR_gateway_address_space | tr '"' "'")
  TF_VAR_vnet_address_space=$(echo $TF_VAR_vnet_address_space | tr '"' "'")
  TF_VAR_private_subnet_address_prefixes=$(echo $TF_VAR_private_subnet_address_prefixes | tr '"' "'")
  TF_VAR_gateway_address_prefixes=$(echo $TF_VAR_gateway_address_prefixes | tr '"' "'")
  echo "{\"application\":\"jAdWRadtTROIA3n1oV0x0w\",\"parameters\":{\"ARM_SUBSCRIPTION_ID\":\"$ARM_SUBSCRIPTION_ID\",\"ARM_TENANT_ID\":\"$ARM_TENANT_ID\",\"ARM_CLIENT_ID\":\"$ARM_CLIENT_ID\",\"ARM_CLIENT_SECRET\":\"$ARM_CLIENT_SECRET\",\"region\":\"$TF_VAR_region\",\"shared_key\":\"$TF_VAR_shared_key\",\"gateway_address\":\"$TF_VAR_gateway_address\",\"gateway_address_space\":\"$TF_VAR_gateway_address_space\",\"asn\":\"$TF_VAR_asn\",\"bgp_peering_address\":\"$TF_VAR_bgp_peering_address\",\"vnet_address_space\":\"$TF_VAR_vnet_address_space\",\"private_subnet_address_prefixes\":\"$TF_VAR_private_subnet_address_prefixes\",\"gateway_address_prefixes\":\"$TF_VAR_gateway_address_prefixes\"}}"
  curl -X POST -H 'content-type: application/json' --url https://app.harness.io/gateway/api/webhooks/WQguWttMZDXVHDht2XfaYfwlPWh3xovlLsAK4HMJ?accountId=6SNoU9GISj6dV8B3Ie5QvA -d "{\"application\":\"jAdWRadtTROIA3n1oV0x0w\",\"parameters\":{\"ARM_SUBSCRIPTION_ID\":\"$ARM_SUBSCRIPTION_ID\",\"ARM_TENANT_ID\":\"$ARM_TENANT_ID\",\"ARM_CLIENT_ID\":\"$ARM_CLIENT_ID\",\"ARM_CLIENT_SECRET\":\"$ARM_CLIENT_SECRET\",\"region\":\"$TF_VAR_region\",\"shared_key\":\"$TF_VAR_shared_key\",\"gateway_address\":\"$TF_VAR_gateway_address\",\"gateway_address_space\":\"$TF_VAR_gateway_address_space\",\"asn\":\"$TF_VAR_asn\",\"bgp_peering_address\":\"$TF_VAR_bgp_peering_address\",\"vnet_address_space\":\"$TF_VAR_vnet_address_space\",\"private_subnet_address_prefixes\":\"$TF_VAR_private_subnet_address_prefixes\",\"gateway_address_prefixes\":\"$TF_VAR_gateway_address_prefixes\"}}"
else
  echo "Directory not currently supported: $DIRECTORY"
fi
