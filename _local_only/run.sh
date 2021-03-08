#!/bin/bash

# #############################################################################
# Run Terraform Command Against Specified Directory
# #############################################################################
# <directory> <command> [command args...]
#
# directory: subscription-bootstrap, network, aks-cluster, aks-service, azure-function-api, or static-website
# command: apply, destroy, validate, or graph
# command args (optional): one or more arguments to be passed to command
# #############################################################################

# Validate Input Count
if [ "$#" -lt 2 ]; then
    echo "Illegal number of parameters; 2 or more expected."
    echo ""
    echo "Usage: <directory> <command> [command args...]"
    echo "  - directory: subscription-bootstrap, network, aks-cluster, aks-service, azure-function-api, or static-website"
    echo "  - command: apply, destroy, validate, or graph"
    echo "  - command args (optional): one or more arguments to be passed to command"
    exit 1
fi

# Normalize Inputs for Validation
DIRECTORY=$(echo "$1" | tr '[:upper:]' '[:lower:]')
COMMAND=$(echo "$2" | tr '[:upper:]' '[:lower:]')

# Validate Directory
if [ -z "$DIRECTORY" ] || ([ "$DIRECTORY" != "subscription-bootstrap" ] &&  [ "$DIRECTORY" != "network" ] && [ "$DIRECTORY" != "aks-cluster" ] && [ "$DIRECTORY" != "aks-service" ] && [ "$DIRECTORY" != "azure-function-api" ] && [ "$DIRECTORY" != "static-website" ]); then
  echo "The first argument must be one of the following: subscription-bootstrap, network, aks-cluster, aks-service, azure-function-api, static-website."
  exit 2
fi

# Validate Command
if [ -z "$COMMAND" ] || ([ "$COMMAND" != "apply" ] &&  [ "$COMMAND" != "destroy" ] && [ "$COMMAND" != "validate" ] && [ "$COMMAND" != "graph" ]); then
  echo "The second argument must be one of the following: apply, destroy, validate, or graph."
  exit 3
fi

# Setup Environment
SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
if [ -f "$SCRIPT_DIRECTORY/env.sh" ]; then
  . $SCRIPT_DIRECTORY/env.sh
else
  echo "*** Variable Initialization Script Missing ***"
  echo "Follow the instructions in the env.template.sh file in the _local_only directory."
  exit 4
fi

cd $SCRIPT_DIRECTORY/../$DIRECTORY/src
terraform init

terraform $COMMAND
