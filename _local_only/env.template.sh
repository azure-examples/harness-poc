#!/bin/bash

# Values required by both the provider and the backend when authenticating as a service principal using a client secret.
export ARM_SUBSCRIPTION_ID=
export ARM_TENANT_ID=
export ARM_CLIENT_ID=
export ARM_CLIENT_SECRET=

# Explicit Terraform Inputs
export TF_VAR_ARM_SUBSCRIPTION_ID=
export TF_LOG_PATH=terraform.log
export TF_LOG=TRACE
