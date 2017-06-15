#!/bin/bash

# the 'class' api is limited, as of this build the network options are not available in devstack
# using just the compute resources.  

# NOTE: Need to look into how the class system works... out of scope this tutorial thought

# Permissions and Ownership.  I've been running into issues surrounding
# 	the creation of the resources being set to users 'default project'
#	instead of the project defined within the attributes set in the command
#	Anyways, this creates a pain point at least using cli commands to provision
#	the resources.


# openstack quota set \
# --class \
#     --ram 2048 \
#     --cores 2 \s
#     --instances 8 \
#     --per-volume-gigabytes 1 \
#     --volumes 8 \
# 3layer_web_app_db_architecture

# share the public network between projects...  (is this a good idea?)

echo "Adding Ip Address Pool"

public_network=$( openstack network show -f value -c id public )
openstack network set --share $public_network

# add project roles, to be assigned later
openstack role create -f value -c id --or-show project_dba
openstack role create -f value -c id --or-show project_admin
openstack role create -f value -c id --or-show project_user
openstack role create -f value -c id --or-show project_dev

admin_project_id=$( openstack project show -f value -c id admin )

# setting up fixed ip address 'scope for projects'
project_address_scope=$( openstack address scope create \
	-f value -c id \
	--share \
	--ip-version 4 \
	--project $admin_project_id \
	projects_ipaddresses_scope )

# create a subnet pool for the ip addresses of the projects
# intersting that the quota has no value set for fixed ip
project_address_pool=$( openstack subnet pool show -f value -c id projects_fixed_ip_pool )
if [ $? -ne 0 ]; then
	project_address_pool=$(openstack subnet pool create \
		-f value -c id \
		--share \
		--pool-prefix 10.11.12.0/22 \
		--default-prefix-length 28 \
		--min-prefix-length 22 \
		--max-prefix-length 31 \
		--address-scope $project_address_scope \
		--description "a pool for the fixed ip addresses customer projects will use." \
		projects_fixed_ip_pool )
fi


# add a security group and ssh rules to only allow ssh from the campus network.

# will have to add a project "campus_project" to do the following:
# openstack security group create "campus_network"

# openstack securtiy group rule create "port 22 from remote-ip/cidr or remote-group (openstack defined sec-group)"

