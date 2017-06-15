#!/bin/bash

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi

: '
###############################################################################
WHAT: source the admin creds to get things started.
WHY: run the following as the admin:admin

'
###############
echo "LOAD Administrator Profile"
. "$DIR/src_admin.sh"
echo "RUNNING as $OS_USERNAME:$OS_PROJECT_NAME ..."

: '
###############
  Review:
    3.1.1 
    - liberty uses OS_TENANT_NAME only, OS_PROJECT_NAME is the future
    - 

###############
  ISSUES:
    - switch roles, allocation issues will araise within the project as 
        admin:admin
    - OS broke while on the cutting edge branch, url_auth maybe a keystone,
        changed to stable/ocata branch and its back working.
##############################################################################'

: '
###############################################################################
"admin only tasks"
  in a real region or os deployment these tasks would only need to be run once,
  or when new setting were required, but not when new projects were being
  deployed.  the following sets up roles, ip address scopes, and other 
  openstack admin tasks again this would be run once or updated sporadically.
tasks:
  1) share the public network between all projects
  2) define orginizational roles ( probably configure them on compute nodes )
  3) create a shared address scope
      relates-to: admin project, networks, ip address pool
  4) create an ip address pool
      relates-to: ip addresses, address scopes, private networks  '
###############
echo "RUNNING SCRIPT:  Provision the global openstack values..."
echo "RUNNING as $OS_USERNAME:$OS_PROJECT_NAME ..."
. "$DIR/admin_policies.sh"

: '
###############
  Review:
    - the "public" should already be created, however verify that all projects
      can access that network.
    - users are given roles within a project, role records are defined by the
      OS "admin" role.  The admin role is a default role set so new OS installs
      can then setup the enviornment(s)
    - address pools may not be available in liberty, they are helpful for admin
      tasks.  Monitoring of the pool would be required, but so would not having
      them in.
    - 

###############
  ISSUES:
##############################################################################'


: '
###############################################################################
add a centos image
tasks:
  1) download the image from centos site
  2) create an os disk image
      relates-to: admin project, shell scripts'
###############
echo "RUNNING SCRIPT:  Upload global images..."
echo "RUNNING as $OS_USERNAME:$OS_PROJECT_NAME ..."
# . "$DIR/upload_image.sh"

: '
###############
  Review:
    4.2
    - glance is the service; openstack image --help ( new service )

###############
  ISSUES:
##############################################################################'

: '
###############################################################################
"Admin Tasks"

admin role required tasks to 'stage' and or allocate the resources required
  - setting up project and adding the user that will deploy this project
  - all the resources need to be allocatated, create a user whom will do this.
tasks:
  1) create the project
  2) modify default quota for project
      relates-to: project, default quota overrides
  3) create the deployer user
      relates-to: project, roles, project scoping  '
###############
echo "RUNNING SCRIPT:  provision project specific values..."
. "$DIR/admin_project_tasks.sh"
: '
###############
  Review:
    - projects are a name space to orginize objects by 
      ( objects being statefull OS generated records )

###############
  ISSUES:
  - tried to use a "template" feature, where i could define a type of IaaS
      which would have a set of minimal defaults required to deploy against,
      i had issues getting it to work. ( look at user role and tenant scope )
##############################################################################'

###############################################################################
###############################################################################
# source the user that will deploy all of the following resources...
###############################################################################
# lets source the deploy user for all of the rest of the tasks to deploy this project
echo "RUNNING as project_deployer:nadams_nih_12345 user..."
. "$DIR/src_project_deployer.sh"
: '
# ISSUES:
#   - the user was set to avoid adding stuff to the wrong project.
#   - at some point this user should be removed.
##############################################################################'

###############################################################################
###############################################################################
# setting up the user access
# tasks:
#   1) create the users
#       relates-to: project
#   2) assign the users roles
#       relates-to: users, defined roles or default roles
###############################################################################
echo "RUNNING SCRIPT:  provision project dependencies..."
. "$DIR/setup_project.sh"
: '
# ISSUES:
#   - ldap or active directory can be setup so that users can login to horizons
#       dashboard, but how those users get access to a project? set by asurite?  
##############################################################################'

###############################################################################
###############################################################################
# setting up the networking
# tasks:
#   1) create networks
#   2) create subnets and assign to the appropriate network
#       relates-to: project, network, ip pool, scoping
#   3) create security group
#       relates-to: project
#   4) create and add rules to security group
#       relates-to: security group, 
###############################################################################
echo "RUNNING SCRIPT:  provision project networks..."
. "$DIR/setup_project_network.sh"
: '
# ISSUES:
#
##############################################################################'


###############################################################################
###############################################################################
# setting up the servers
# tasks:
#   1) set up user rsa keys
#   2) create the volumes
#   3) create the servers
#       relates-to: volumes, keys, security groups, project, network
#   4) create the floating ips
#       relates-to: public network, project, 
#   5) add the floating ips to servers
#       relates-to: floating ips, server
echo "RUNNING SCRIPT:  provision project servers..."
. "$DIR/setup_compute.sh"

: '
# ISSUES:
# 1) ran into an "interesting" issue... --project is ALL over the place... 
#    but not when spinning up a server the OS_TENANT_NAME value I believe is what
#    sets where the instance is assigned to.
# 2) the volumes seemed to have a very similar issue, the user issuing the cmd
#    even when the project was explicitly set
#
# Solution: Created the project_deployer user setting all 'pointers' to the
#           project the resources should be assigned to.  
#    
##############################################################################'




###############################################################################
# 
# tasks:
###############################################################################
echo "RUNNING SCRIPT:  provision shell script here..."
: '
# ISSUES:
#
##############################################################################'

