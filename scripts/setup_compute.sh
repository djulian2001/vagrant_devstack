#!/bin/bash

# set the variables
image_id=$( openstack image show -f value -c id "cirros-0.3.4-x86_64-uec" )
flavor_id=$( openstack flavor show -f value -c id m1.nano )

project_id=$( openstack project show -f value -c id nadams_nih_12345 )
volume_type_id=$( openstack volume type show -f value -c id "lvmdriver-1" )

web_network=$( openstack network show -f value -c id project_web_network )
app_network=$( openstack network show -f value -c id project_app_network )
data_network=$( openstack network show -f value -c id project_data_network )

###############################################################################
# the admin user rsa keys
###############################################################################
# build the key pairs
bobfile="/vagrant/scripts/ssh/bob_ssh_key.pub"
janefile="/vagrant/scripts/ssh/jane_ssh_key.pub"
nickfile="/vagrant/scripts/ssh/nick_ssh_key.pub"
chuckfile="/vagrant/scripts/ssh/chuck_ssh_key.pub"
sarafile="/vagrant/scripts/ssh/sara_ssh_key.pub"

# dba's rsa key...
dbabobkey=$( openstack keypair show -f value -c id bob_ssh_key )
if [ $? -ne 0 ]; then 
	dbabobkey=$( openstack keypair create -f value -c id --public-key "$bobfile" bob_ssh_key )
fi
# admin's rsa key...
adminjanekey=$( openstack keypair show -f value -c id jane_ssh_key )	
if [ $? -ne 0 ]; then
	adminjanekey=$( openstack keypair create -f value -c id --public-key "$janefile" jane_ssh_key )
fi
# dev1's rsa key...
dev1nickkey=$( openstack keypair show -f value -c id nick_ssh_key )
if [ $? -ne 0 ]; then 
	dev1nickkey=$( openstack keypair create -f value -c id --public-key "$nickfile" nick_ssh_key )
fi
# dev2's rsa key...
dev2chuckkey=$( openstack keypair show -f value -c id chuck_ssh_key )
if [ $? -ne 0 ]; then
	dev2chuckkey=$( openstack keypair create -f value -c id --public-key "$chuckfile" chuck_ssh_key )
fi
# dev3's rsa key...
dev3sarakey=$( openstack keypair show -f value -c id sara_ssh_key )
if [ $? -ne 0 ]; then
	dev3sarakey=$( openstack keypair create -f value -c id --public-key "$sarafile" sara_ssh_key )
fi

###############################################################################
# the volumes
###############################################################################
# for each volume instances volume... data_volume .. webapp1_volume, webapp2_volume ..
# Again, there was an issue with permissions and ownership.  When this was first
# 	run with the admin user, the volumes were added to the 'admin' project, even
# 	though the --project flag was set.
volume_db=$( openstack volume show -f value -c id project_volume_db )
if [ $? -ne 0 ]; then
	volume_db=$(
		openstack volume create -f value -c id \
			--size 1 \
			--type "$volume_type_id" \
			--project "$project_id" \
			--read-write \
			--description "volume for the instance _db" \
			--non-bootable \
		"project_volume_db" )
fi
volume_app1=$( openstack volume show -f value -c id project_volume_app1 )
if [ $? -ne 0 ]; then
	volume_app1=$(
		openstack volume create -f value -c id \
			--size 1 \
			--type "$volume_type_id" \
			--project "$project_id" \
			--read-write \
			--description "volume for the instance _app1" \
			--non-bootable \
		"project_volume_app1" )
fi
volume_app2=$( openstack volume show -f value -c id project_volume_app2 )
if [ $? -ne 0 ]; then
	volume_app2=$(
		openstack volume create -f value -c id \
			--size 1 \
			--type "$volume_type_id" \
			--project "$project_id" \
			--read-write \
			--description "volume for the instance _app2" \
			--non-bootable \
		"project_volume_app2" )
fi
volume_app3=$( openstack volume show -f value -c id project_volume_app3 )
if [ $? -ne 0 ]; then
	volume_app3=$(
		openstack volume create -f value -c id \
			--size 1 \
			--type "$volume_type_id" \
			--project "$project_id" \
			--read-write \
			--description "volume for the instance _app3" \
			--non-bootable \
		"project_volume_app3" )
fi
volume_web=$( openstack volume show -f value -c id project_volume_web )
if [ $? -ne 0 ]; then
	volume_web=$(
		openstack volume create -f value -c id \
			--size 1 \
			--type "$volume_type_id" \
			--project "$project_id" \
			--read-write \
			--description "volume for the instance _web" \
			--non-bootable \
		"project_volume_web" )
fi

# openstack volume unset "project_volume_db"
# openstack volume delete --force "project_volume_db"
# openstack volume unset "project_volume_app1"
# openstack volume delete --force "project_volume_app1"
# openstack volume unset "project_volume_app2"
# openstack volume delete --force "project_volume_app2"
# openstack volume unset "project_volume_app3"
# openstack volume delete --force "project_volume_app3"
# openstack volume unset "project_volume_web"
# openstack volume delete --force "project_volume_web"



# template just replace the _name with _mynewname
# volume_name=$( openstack volume show -f value -c id project_volume_name )
# if [ $? -ne 0 ]; then
# 	volume_name=$(
# 		openstack volume create -f value -c id \
# 			--size 1 \
# 			--type "$volume_type_id" \
# 			--project "$project_id" \
# 			--read-write \
# 			--description "volume for the instance _name" \
# 			--non-bootable \
# 		"project_volume_name" )
# fi


###############################################################################
# build the servers
###############################################################################
# template command:
# security_group_id=$( openstack security group show -f value -c id security_group_id )
# project_server_name=$( openstack server show -f value -c id project_server_name )
# if [ $? -ne 0 ]; then
# 	project_server_name=$(
# 		openstack server create -f value -c id \
# 			--image "$image_id" \
# 			--flavor "$flavor_id" \
# 			--security-group "$security_group_id" \
# 			--key-name "jane_ssh_key" \
# 			--nic net-id="$_XXX_subnet" \
# 		"project_server_name" )
# fi
# add 1 web instance
fake_campus_security_group=$( openstack security group show -f value -c id fake_campus_security_group )
web_security_group=$( openstack security group show -f value -c id web_security_group )
project_server_loadbalancer=$( openstack server show -f value -c id "web.loadbalancer" )
if [ $? -ne 0 ]; then
	project_server_loadbalancer=$(
		openstack server create -f value -c id \
			--image "$image_id" \
			--flavor "$flavor_id" \
			--nic net-id="$web_network" \
			--availability-zone nova \
			--security-group "$fake_campus_security_group" \
			--security-group "$web_security_group" \
			--key-name "jane_ssh_key" \
		"web.loadbalancer" )
fi
# add 3 app instance
# web.app1
app_web_security_group=$( openstack security group show -f value -c id app_web_security_group )
project_server_app_web1=$( openstack server show -f value -c id project_server_app_web1 )
if [ $? -ne 0 ]; then
	project_server_app_web1=$(
		openstack server create -f value -c id \
			--image "$image_id" \
			--flavor "$flavor_id" \
			--security-group "$app_web_security_group" \
			--key-name "jane_ssh_key" \
			--nic net-id="$app_network" \
		"project_server_app_web1" )
fi

# web.app2
project_server_app_web2=$( openstack server show -f value -c id project_server_app_web2 )
if [ $? -ne 0 ]; then
	project_server_app_web2=$(
		openstack server create -f value -c id \
			--image "$image_id" \
			--flavor "$flavor_id" \
			--security-group "$app_web_security_group" \
			--key-name "jane_ssh_key" \
			--nic net-id="$app_network" \
		"project_server_app_web2" )
fi
# internal.app
app_security_group=$( openstack security group show -f value -c id app_security_group )
project_server_internal_app=$( openstack server show -f value -c id project_server_internal_app )
if [ $? -ne 0 ]; then
	project_server_internal_app=$(
		openstack server create -f value -c id \
			--image "$image_id" \
			--flavor "$flavor_id" \
			--security-group "$app_security_group" \
			--key-name "jane_ssh_key" \
			--nic net-id="$app_network" \
		"project_server_internal_app" )
fi
# backend database
data_security_group=$( openstack security group show -f value -c id data_security_group )
project_server_database=$( openstack server show -f value -c id project_server_database )
if [ $? -ne 0 ]; then
	project_server_database=$(
		openstack server create -f value -c id \
			--image "$image_id" \
			--flavor "$flavor_id" \
			--security-group "$data_security_group" \
			--key-name "jane_ssh_key" \
			--nic net-id="$data_network" \
		"project_server_database" )
fi


###############################################################################
# ADD the volumes to the servers
###############################################################################
# add the volumes...  NOTE: when adding volumes ensure that the project is properly assigned.
#   I had issues when the user creating the objects tried to assign them, even been the porject
#	was set at the time the resource was created
openstack server add volume "$project_server_loadbalancer" "$volume_web"
openstack server add volume "$project_server_app_web2" "$volume_app2"
openstack server add volume "$project_server_app_web1" "$volume_app1"
openstack server add volume "$project_server_internal_app" "$volume_app3"
openstack server add volume "$project_server_database" "$volume_db"


###############################################################################
# create a floating ip address and add it to the server...
###############################################################################
# create the ip address...
public_network=$( openstack network show -f value -c id "public" )
web_subnetwork=$( openstack subnet show -f value -c id "project_web_subnet" )
to_add_floating_id_lb=$( openstack floating ip show -f value -c floating_ip_address "192.168.33.227" )
if [ $? -ne 0 ]; then
	to_add_floating_id_lb=$(
		openstack floating ip create -f value -c floating_ip_address \
			--project "$project_id" \
			--description "public routable ip address to project webserver" \
			--subnet "$web_subnetwork" \
			--floating-ip-address "192.168.33.227" \
		"$public_network" )
fi

# add the ip address to the server
openstack server add floating ip "$project_server_loadbalancer" "$to_add_floating_id_lb"

# we need to add a floating ip address to the app server to ssh into it
internal_app_subnet=$( openstack subnet show -f value -c id "project_web_subnet" )
to_add_floating_id_app=$( openstack floating ip show -f value -c floating_ip_address "192.168.33.228" )
if [ $? -ne 0 ]; then
	to_add_floating_id_app=$(
		openstack floating ip create -f value -c floating_ip_address \
			--project "$project_id" \
			--description "public routable ip address to projects internal app server" \
			--subnet "$internal_app_subnet" \
			--floating-ip-address "192.168.33.228" \
		"$public_network" )
fi

# add the external ip address to allow me to ssh into the box
openstack server add floating ip "$project_server_internal_app" "$to_add_floating_id_app"

###############################################################################
# 
###############################################################################
 



