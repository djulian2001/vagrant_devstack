#!/bin/bash

# set needed variables out of openstack
project_id=$( openstack project show -f value -c id nadams_nih_12345 )
fixed_ip_pool=$( openstack subnet pool show -f value -c id projects_fixed_ip_pool )

###############################################################################
# the networks and subnets
###############################################################################
# create the 3 networks webnet appnet datanet
network_web=$( openstack network show -f value -c id project_web_network )
if [ -z $network_web ]; then
    network_web=$( openstack network create -f value -c id \
        --internal --no-share \
        --project "$project_id" \
        --description "Neal Adams front end (web) network" \
    project_web_network )
fi

network_app=$( openstack network show -f value -c id project_app_network )
if [ -z $network_app ]; then
    network_app=$( openstack network create -f value -c id \
        --internal --no-share \
        --project "$project_id" \
        --description "Neal Adams middle layer (app) network" \
    project_app_network )
fi

network_data=$( openstack network show -f value -c id project_data_network )
if [ -z $network_data ]; then
    network_data=$( openstack network create -f value -c id \
        --internal --no-share \
        --project "$project_id" \
        --description "Neal Adams back end (data) network" \
        project_data_network )
fi

# add the subnets
# NOTE output... bad behavior... "ResourceNotFound: No Subnet found for <subnet_name>"
web_subnet=$( openstack subnet show -f value -c id project_web_subnet )
if [ $? -ne 0 ]; then
    web_subnet=$( openstack subnet create \
        -f value -c id \
        --dhcp \
        --gateway auto \
        --project $project_id \
        --subnet-pool $fixed_ip_pool \
        --prefix-length 29 \
        --network $network_web \
        --description "project web subnet interface" \
    project_web_subnet )
fi

app_subnet=$( openstack subnet show -f value -c id project_app_subnet )
if [ $? -ne 0 ]; then
    app_subnet=$( openstack subnet create \
        -f value -c id \
        --dhcp \
        --gateway auto \
        --project $project_id \
        --subnet-pool $fixed_ip_pool \
        --prefix-length 28 \
        --network $network_app \
        --description "project app subnet interface" \
    project_app_subnet )
fi

data_subnet=$( openstack subnet show -f value -c id project_data_subnet )
if [ $? -ne 0 ]; then
    data_subnet=$( openstack subnet create \
        -f value -c id \
        --dhcp \
        --gateway auto \
        --project $project_id \
        --subnet-pool $fixed_ip_pool \
        --prefix-length 29 \
        --network $network_data \
        --description "project data subnet interface" \
    project_data_subnet )
fi


###############################################################################
# the router
###############################################################################
# setup the public network
public_network=$( openstack network show -f value -c id public )

# add the router
project_router=$( openstack router show -f value -c id project_router )
if [ $? -ne 0 ]; then
    project_router=$(openstack router create \
        -f value -c id \
        --enable \
        --project $project_id \
        --description "the router for the research project" \
    project_router )
fi

# the following automates a lot...  probably want to know what!?!
openstack router set $project_router --external-gateway $public_network
# public_subnet=$( openstack subnet show -f value -c id public-subnet )

# like the following port is added to the public network...
# public_port=$( openstack port show -f value -c id project_public_port )
# if [ $? -ne 0 ]; then
#   public_port=$( openstack port create \
#       --project $project_id \
#       --network $public_network \
#       --device-owner network:router_gateway \
#       --fixed-ip subnet=$public_subnet,ip-address=192.168.33.230 \
#       --vnic-type normal \
#       --enable \
#       --description "port for projects public network access" \
#   project_public_port )
# fi



# add the private subnets to the router
openstack router add subnet $project_router $web_subnet
openstack router add subnet $project_router $app_subnet
openstack router add subnet $project_router $data_subnet




###############################################################################
# the security groups and rules:
###############################################################################
fake_campus_security_group=$( openstack security group show -f value -c id fake_campus_security_group )
if [ $? -ne 0 ]; then
    fake_campus_security_group=$( openstack security group create \
        -f value -c id \
        --description "internal route between load balancer, public traffic, and application servers" \
        --project "$project_id" \
        fake_campus_security_group )
fi



# public web security group:
web_security_group=$( openstack security group show -f value -c id web_security_group )
if [ $? -ne 0 ]; then
    web_security_group=$( openstack security group create \
        -f value -c id \
        --description "Public route into the survey software stack" \
        --project "$project_id" \
        web_security_group )
fi 

# add rules to the web security group...
# port 80 route.
openstack security group rule create \
    --remote-ip "0.0.0.0/0" \
    --description "http traffic" \
    --dst-port 80 \
    --protocol tcp \
    --ingress \
    --ethertype IPv4 \
    --project "$project_id" \
"$web_security_group"
# port 443 route.
openstack security group rule create \
    --remote-ip "0.0.0.0/0" \
    --description "https traffic" \
    --dst-port 443 \
    --protocol tcp \
    --ingress \
    --ethertype IPv4 \
    --project "$project_id" \
"$web_security_group"


# application server:
# add the security groups
app_web_security_group=$( openstack security group show -f value -c id app_web_security_group )
if [ $? -ne 0 ]; then
    app_web_security_group=$( openstack security group create \
        -f value -c id \
        --description "internal route between load balancer, public traffic, and application servers" \
        --project "$project_id" \
        app_web_security_group )
fi

# web apps ports (80:8080)
openstack security group rule create \
    --remote-ip "10.11.12.0/28" \
    --description "http traffic from load balancer" \
    --dst-port 8080 \
    --protocol tcp \
    --ingress \
    --ethertype IPv4 \
    --project "$project_id" \
"$app_web_security_group"

# web app port (443:44300)
openstack security group rule create \
    --remote-ip "10.11.12.0/28" \
    --description "http traffic from load balancer" \
    --dst-port 44300 \
    --protocol tcp \
    --ingress \
    --ethertype IPv4 \
    --project "$project_id" \
"$app_web_security_group"

# internal app server
app_security_group=$( openstack security group show -f value -c id app_security_group )
if [ $? -ne 0 ]; then
    app_security_group=$( openstack security group create \
        -f value -c id \
        --description "internal route between load balancer, public traffic, and application servers" \
        --project "$project_id" \
        app_security_group )
fi 

# ssh port
openstack security group rule create \
    --remote-group "$fake_campus_security_group" \
    --description "ssh connection to fake campus network" \
    --dst-port 22 \
    --ethertype IPv4 \
    --protocol tcp \
"$app_security_group"

openstack security group rule create \
    --remote-ip "192.168.33.224/27" \
    --description "ssh connection to public network" \
    --dst-port 22 \
    --ethertype IPv4 \
    --protocol tcp \
"$app_security_group"


# database server:
data_security_group=$( openstack security group show -f value -c id data_security_group )
if [ $? -ne 0 ]; then
    data_security_group=$( openstack security group create \
        -f value -c id \
        --description "internal route between load balancer, public traffic, and application servers" \
        --project "$project_id" \
        data_security_group )
fi 
# database port 5432 from the application network 10.11.12.16/28
openstack security group rule create \
    --remote-ip "10.11.12.16/28" \
    --description "database tcp/ip communication" \
    --ethertype IPv4 \
    --dst-port 5432 \
    --protocol tcp \
"$data_security_group"

# ssh port 22 from the application network 10.11.12.16/28
openstack security group rule create \
    --remote-ip "10.11.12.16/28" \
    --description "ssh connections from app network" \
    --ethertype IPv4 \
    --dst-port 22 \
    --protocol tcp \
"$data_security_group"

