#!/bin/bash
# set project usage

openstack quota set \
    --class 3layer_web_app_db_architecture \
    --server-groups 4 \
    --server-group-members 8\
    --key-pairs 10 \
    --floating-ips 2 \
    --networks 4



# set up a 3 teir arch quota
# there will be 
# 3 networks... 1 with public access, the other 2 will have only internal access 
# we have 2 'shared' networks, but those should not count against the networks quota for this class
#   hpc, campus


openstack quota set [-h]
    [--class]
    [--properties <properties>]
    
    # compute settings:
    [--server-groups <server-groups>]
    [--server-group-members <server-group-members>]
    
    [--ram <ram> UNIT as MB]
    [--cores <cores>]

    [--key-pairs <key-pairs>]
    [--instances <instances>]
    [--fixed-ips <fixed-ips>]
    
    [--injected-file-size <injected-file-size>]
    [--injected-files <injected-files>]
    [--injected-path-size <injected-path-size>]
    # Block Storage settings
    [--gigabytes <gigabytes>]
    [--per-volume-gigabytes <per-volume-gigabytes>]

    [--backup-gigabytes <backup-gigabytes>]
    [--snapshots <snapshots>]
    [--volumes <volumes>]
    [--backups <backups>]
    [--l7policies <l7policies>]
    [--subnetpools <subnetpools>]
    [--vips <vips>]
    [--ports <ports>]
    [--subnets <subnets>]
    [--networks <networks>]
    [--floating-ips <floating-ips>]
    [--secgroup-rules <secgroup-rules>]
    [--health-monitors <health-monitors>]
    [--secgroups <secgroups>]
    [--routers <routers>]
    [--rbac-policies <rbac-policies>]
    [--volume-type <volume-type>]
<project/class>

# Set quotas for project or class

# positional arguments:
#   <project/class>       Set quotas for this project or class (name/ID)

# optional arguments:
#   -h, 
--help            show this help message and exit
#   --class               Set quotas for <class>
#   --properties <properties>
#                         New value for the properties quota
#   --server-groups <server-groups>
#                         New value for the server-groups quota
#   --ram <ram>           New value for the ram quota
#   --key-pairs <key-pairs>
#                         New value for the key-pairs quota
#   --instances <instances>
#                         New value for the instances quota
#   --fixed-ips <fixed-ips>
#                         New value for the fixed-ips quota
#   --injected-file-size <injected-file-size>
#                         New value for the injected-file-size quota
#   --server-group-members <server-group-members>
#                         New value for the server-group-members quota
#   --injected-files <injected-files>
#                         New value for the injected-files quota
#   --cores <cores>       New value for the cores quota
#   --injected-path-size <injected-path-size>
#                         New value for the injected-path-size quota
#   --per-volume-gigabytes <per-volume-gigabytes>
#                         New value for the per-volume-gigabytes quota
#   --gigabytes <gigabytes>
#                         New value for the gigabytes quota
#   --backup-gigabytes <backup-gigabytes>
#                         New value for the backup-gigabytes quota
#   --snapshots <snapshots>
#                         New value for the snapshots quota
#   --volumes <volumes>   New value for the volumes quota
#   --backups <backups>   New value for the backups quota
#   --l7policies <l7policies>
#                         New value for the l7policies quota
#   --subnetpools <subnetpools>
#                         New value for the subnetpools quota
#   --vips <vips>         New value for the vips quota
#   --ports <ports>       New value for the ports quota
#   --subnets <subnets>   New value for the subnets quota
#   --networks <networks>
#                         New value for the networks quota
#   --floating-ips <floating-ips>
#                         New value for the floating-ips quota
#   --secgroup-rules <secgroup-rules>
#                         New value for the secgroup-rules quota
#   --health-monitors <health-monitors>
#                         New value for the health-monitors quota
#   --secgroups <secgroups>
#                         New value for the secgroups quota
#   --routers <routers>   New value for the routers quota
#   --rbac-policies <rbac-policies>
#                         New value for the rbac-policies quota
#   --volume-type <volume-type>
#                         Set quotas for a specific <volume-type>

