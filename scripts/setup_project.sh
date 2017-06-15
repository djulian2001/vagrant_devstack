#!/bin/bash

project_id=$( openstack project show -f value -c id "nadams_nih_12345" )

# create the users:
# reference os_users.sh
user_dba=$( openstack user create -f value -c id --or-show --project "$project_id" --password bob --enable bob )
user_admin=$( openstack user create -f value -c id --or-show --project "$project_id" --password jane --enable jane )
user_dev1=$( openstack user create -f value -c id --or-show --project "$project_id" --password nick --enable nick )
user_dev2=$( openstack user create -f value -c id --or-show --project "$project_id" --password chuck --enable chuck )
user_dev3=$( openstack user create -f value -c id --or-show --project "$project_id" --password sara --enable sara )

# assign the user roles to the project * NOTE below *
openstack role add --user admin --project "$project_id" admin
openstack role add --user "$user_dev1" --project "$project_id" project_dev
openstack role add --user "$user_dev2" --project "$project_id" project_dev
openstack role add --user "$user_dev3" --project "$project_id" project_dev
openstack role add --user "$user_admin" --project "$project_id" project_admin
openstack role add --user "$user_dba" --project "$project_id" project_dba

# * NOTE:  currently cannot check the existence of the value, so we get a error:
# openstack role assignment list --role project_dba --user bob --project nadams_nih_12345

