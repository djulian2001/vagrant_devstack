#!/bin/bash
# export OS_USERNAME="admin"
# export OS_PASSWORD="stack"
# export OS_PROJECT_NAME=""
# export OS_PROJECT_ID=""
# export OS_USER_DOMAIN_ID="default"
# export OS_USER_DOMAIN_NAME="default"
# export OS_PROJECT_DOMAIN_ID=""
# export OS_PROJECT_DOMAIN_NAME="default"
# export OS_AUTH_URL="127.0.0.1:5000/v2.0" 
# export OS_CACERT=""

# devstack
export OS_USERNAME="admin"
export OS_PASSWORD="stack"
export OS_TENANT_NAME="admin"
export OS_PROJECT_NAME="$OS_TENANT_NAME"
export OS_AUTH_URL="http://127.0.0.1:5000/v2.0"

