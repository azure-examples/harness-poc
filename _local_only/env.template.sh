#!/bin/bash

# Values required by both the provider and the backend when authenticating as a service principal using a client secret.
export ARM_SUBSCRIPTION_ID=
export ARM_TENANT_ID=
export ARM_CLIENT_ID=
export ARM_CLIENT_SECRET=

# Explicit Terraform Inputs
export TF_VAR_ARM_SUBSCRIPTION_ID=

# Explicit Terraform Inputs for network
export TF_VAR_region=
export TF_VAR_shared_key=
export TF_VAR_gateway_address=
export TF_VAR_gateway_address_space=
export TF_VAR_asn=
export TF_VAR_bgp_peering_address=
export TF_VAR_vnet_address_space=
export TF_VAR_private_subnet_address_prefixes=
export TF_VAR_gateway_address_prefixes=

# Uncomment to Enable Debugging
# export TF_LOG_PATH=terraform.log
# export TF_LOG=TRACE
