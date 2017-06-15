#!/bin/bash

# openstack uses nova service to build the vms.  Nova has been integrated into the openstack cli suite.

$ openstack server --help
Command "server" matches:
  server add fixed ip
  server add floating ip
  server add security group
  server add volume
  server backup create
  server create
  server delete
  server dump create
  server group create
  server group delete
  server group list
  server group show
  server image create
  server list
  server lock
  server migrate
  server pause
  server reboot
  server rebuild
  server remove fixed ip
  server remove floating ip
  server remove security group
  server remove volume
  server rescue
  server resize
  server restore
  server resume
  server set
  server shelve
  server show
  server ssh
  server start
  server stop
  server suspend
  server unlock
  server unpause
  server unrescue
  server unset
  server unshelve

# So lets look into the server create.
# construct the servers for the project.

openstack volume type show -f value -c id "lvmdriver-1"
openstack volume create \
	--size 1 \
	--type "$volume_type_id" \
	--project "$project_id" \
	--read-only OR --read-write \
	--description "add volume description" \
	--non-bootable \
"volume_name"




openstack server create -f value -c id \
	--image "$image_id" \
	--volume "$volume_id" \
	--flavor "$flavor_id" \
	--security-group "$security_group_id" \
	--


$ openstack server create --help
usage: openstack server create [-h] [-f {json,shell,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>]
                               [--print-empty] [--noindent] [--prefix PREFIX]
                               (--image <image> | --volume <volume>) --flavor
                               <flavor>
                               [--security-group <security-group-name>]
                               [--key-name <key-name>]
                               [--property <key=value>]
                               [--file <dest-filename=source-filename>]
                               [--user-data <user-data>]
                               [--availability-zone <zone-name>]
                               [--block-device-mapping <dev-name=mapping>]
                               [--nic <net-id=net-uuid,v4-fixed-ip=ip-addr,v6-fixed-ip=ip-addr,port-id=port-uuid,auto,none>]
                               [--hint <key=value>]
                               [--config-drive <config-drive-volume>|True]
                               [--min <count>] [--max <count>] [--wait]
                               <server-name>

Create a new server

positional arguments:
  <server-name>         New server name

optional arguments:
  -h, --help            show this help message and exit
  --image <image>       Create server boot disk from this image (name or ID)
  --volume <volume>     Create server using this volume as the boot disk (name
                        or ID)
  --flavor <flavor>     Create server with this flavor (name or ID)
  --security-group <security-group-name>
                        Security group to assign to this server (name or ID)
                        (repeat option to set multiple groups)
  --key-name <key-name>
                        Keypair to inject into this server (optional
                        extension)
  --property <key=value>
                        Set a property on this server (repeat option to set
                        multiple values)
  --file <dest-filename=source-filename>
                        File to inject into image before boot (repeat option
                        to set multiple files)
  --user-data <user-data>
                        User data file to serve from the metadata server
  --availability-zone <zone-name>
                        Select an availability zone for the server
  --block-device-mapping <dev-name=mapping>
                        Map block devices; map is
                        <id>:<type>:<size(GB)>:<delete_on_terminate> (optional
                        extension)
  --nic <net-id=net-uuid,v4-fixed-ip=ip-addr,v6-fixed-ip=ip-addr,port-id=port-uuid,auto,none>
                        Create a NIC on the server. Specify option multiple
                        times to create multiple NICs. Either net-id or port-
                        id must be provided, but not both. net-id: attach NIC
                        to network with this UUID, port-id: attach NIC to port
                        with this UUID, v4-fixed-ip: IPv4 fixed address for
                        NIC (optional), v6-fixed-ip: IPv6 fixed address for
                        NIC (optional), none: (v2.37+) no network is attached,
                        auto: (v2.37+) the compute service will automatically
                        allocate a network. Specifying a --nic of auto or none
                        cannot be used with any other --nic value.
  --hint <key=value>    Hints for the scheduler (optional extension)
  --config-drive <config-drive-volume>|True
                        Use specified volume as the config drive, or 'True' to
                        use an ephemeral drive
  --min <count>         Minimum number of servers to launch (default=1)
  --max <count>         Maximum number of servers to launch (default=1)
  --wait                Wait for build to complete

output formatters:
  output formatter options

  -f {json,shell,table,value,yaml}, --format {json,shell,table,value,yaml}
                        the output format, defaults to table
  -c COLUMN, --column COLUMN
                        specify the column(s) to include, can be repeated

table formatter:
  --max-width <integer>
                        Maximum display width, <1 to disable. You can also use
                        the CLIFF_MAX_TERM_WIDTH environment variable, but the
                        parameter takes precedence.
  --print-empty         Print empty table if there is no data to show.

json formatter:
  --noindent            whether to disable indenting the JSON

shell formatter:
  a format a UNIX shell can parse (variable="value")

  --prefix PREFIX       add a prefix to all variable names