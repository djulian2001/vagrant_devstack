#!/bin/bash

# create the project and add all the users for the project
# project
project_id=$( openstack project create \
    -f value -c id \
    --description "neal adams and jill xavier project" \
    --enable \
    --or-show \
    "nadams_nih_12345" )

# set project usage
# reference:  os_project_quota.sh
openstack quota set \
    --server-groups 4 \
    --server-group-members 8 \
    --key-pairs 10 \
    --floating-ips 2 \
    --networks 4 \
    --ram 2048 \
    --cores 5 \
    --instances 8 \
    --per-volume-gigabytes 1 \
    --volumes 8 \
"$project_id"

# need the deploy user to have admin permission.
admin_role_id=$( openstack role show -f value -c id "admin" )

# create the project_deployer and grant all required access.
# as the admin user
user_id=$(
	openstack user create -f value -c id \
		--project "$project_id" \
		--password "deployer" \
		--enable \
		--or-show \
	"project_deployer" )

# in theroy this should give the deploy user the access to create all of the objects...

openstack role add -f value -c id --project "$project_id" --user "$user_id" "$admin_role_id"

# at this point, all of the project assignments should come from the deploy user?
# 	i think yes lets see..