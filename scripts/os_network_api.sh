#!/bin/bash

# openstack network create cli api
# NETWORK (create)
vagrant@vagrant:/vagrant/scripts$ openstack network create --help
usage: openstack network create [-h] [-f {json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>]
                                [--print-empty] [--noindent] [--prefix PREFIX]
                                [--share | --no-share] [--enable | --disable]
                                [--project <project>]
                                [--description <description>]
                                [--project-domain <project-domain>]
                                [--availability-zone-hint <availability-zone>]
                                [--enable-port-security | --disable-port-security]
                                [--external | --internal]
                                [--default | --no-default]
                                [--qos-policy <qos-policy>]
                                [--provider-network-type <provider-network-type>]
                                [--provider-physical-network <provider-physical-network>]
                                [--provider-segment <provider-segment>]
                                [--transparent-vlan | --no-transparent-vlan]
                                <name>

Create new network

positional arguments:
  <name>                New network name

optional arguments:
  -h, --help            show this help message and exit
  --share               Share the network between projects
  --no-share            Do not share the network between projects
  --enable              Enable network (default)
  --disable             Disable network
  --project <project>   Owners project (name or ID)
  --description <description>
                        Set network description
  --project-domain <project-domain>
                        Domain the project belongs to (name or ID). This can
                        be used in case collisions between project names
                        exist.
  --availability-zone-hint <availability-zone>
                        Availability Zone in which to create this network
                        (Network Availability Zone extension required, repeat
                        option to set multiple availability zones)
  --enable-port-security
                        Enable port security by default for ports created on
                        this network (default)
  --disable-port-security
                        Disable port security by default for ports created on
                        this network
  --external            Set this network as an external network (external-net
                        extension required)
  --internal            Set this network as an internal network (default)
  --default             Specify if this network should be used as the default
                        external network
  --no-default          Do not use the network as the default external network
                        (default)
  --qos-policy <qos-policy>
                        QoS policy to attach to this network (name or ID)
  --provider-network-type <provider-network-type>
                        The physical mechanism by which the virtual network is
                        implemented. For example: flat, geneve, gre, local,
                        vlan, vxlan.
  --provider-physical-network <provider-physical-network>
                        Name of the physical network over which the virtual
                        network is implemented
  --provider-segment <provider-segment>
                        VLAN ID for VLAN networks or Tunnel ID for
                        GENEVE/GRE/VXLAN networks
  --transparent-vlan    Make the network VLAN transparent
  --no-transparent-vlan
                        Do not make the network VLAN transparent

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



  # SUBNET (create)
openstack subnet create -f value -c id
-- project "$project_id"
--subnet-range



vagrant@vagrant:/vagrant/scripts$ openstack subnet create --help
usage: openstack subnet create [-h] [-f {json,shell,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>]
                               [--print-empty] [--noindent] [--prefix PREFIX]
                               [--project <project>]
                               [--project-domain <project-domain>]
                               [--subnet-pool <subnet-pool> | --use-default-subnet-pool]
                               [--prefix-length <prefix-length>]
                               [--subnet-range <subnet-range>]
                               [--dhcp | --no-dhcp] [--gateway <gateway>]
                               [--ip-version {4,6}]
                               [--ipv6-ra-mode {dhcpv6-stateful,dhcpv6-stateless,slaac}]
                               [--ipv6-address-mode {dhcpv6-stateful,dhcpv6-stateless,slaac}]
                               [--network-segment <network-segment>] --network
                               <network> [--description <description>]
                               [--allocation-pool start=<ip-address>,end=<ip-address>]
                               [--dns-nameserver <dns-nameserver>]
                               [--host-route destination=<subnet>,gateway=<ip-address>]
                               [--service-type <service-type>]
                               name

Create a subnet

positional arguments:
  name                  New subnet name

optional arguments:
  -h, --help            show this help message and exit
  --project <project>   Owners project (name or ID)
  --project-domain <project-domain>
                        Domain the project belongs to (name or ID). This can
                        be used in case collisions between project names
                        exist.
  --subnet-pool <subnet-pool>
                        Subnet pool from which this subnet will obtain a CIDR
                        (Name or ID)
  --use-default-subnet-pool
                        Use default subnet pool for --ip-version
  --prefix-length <prefix-length>
                        Prefix length for subnet allocation from subnet pool
  --subnet-range <subnet-range>
                        Subnet range in CIDR notation (required if --subnet-
                        pool is not specified, optional otherwise)
  --dhcp                Enable DHCP (default)
  --no-dhcp             Disable DHCP
  --gateway <gateway>   Specify a gateway for the subnet. The three options
                        are: <ip-address>: Specific IP address to use as the
                        gateway, 'auto': Gateway address should automatically
                        be chosen from within the subnet itself, 'none': This
                        subnet will not use a gateway, e.g.: --gateway
                        192.168.9.1, --gateway auto, --gateway none (default
                        is 'auto').
  --ip-version {4,6}    IP version (default is 4). Note that when subnet pool
                        is specified, IP version is determined from the subnet
                        pool and this option is ignored.
  --ipv6-ra-mode {dhcpv6-stateful,dhcpv6-stateless,slaac}
                        IPv6 RA (Router Advertisement) mode, valid modes:
                        [dhcpv6-stateful, dhcpv6-stateless, slaac]
  --ipv6-address-mode {dhcpv6-stateful,dhcpv6-stateless,slaac}
                        IPv6 address mode, valid modes: [dhcpv6-stateful,
                        dhcpv6-stateless, slaac]
  --network-segment <network-segment>
                        Network segment to associate with this subnet (name or
                        ID)
  --network <network>   Network this subnet belongs to (name or ID)
  --description <description>
                        Set subnet description
  --allocation-pool start=<ip-address>,end=<ip-address>
                        Allocation pool IP addresses for this subnet e.g.:
                        start=192.168.199.2,end=192.168.199.254 (repeat option
                        to add multiple IP addresses)
  --dns-nameserver <dns-nameserver>
                        DNS server for this subnet (repeat option to set
                        multiple DNS servers)
  --host-route destination=<subnet>,gateway=<ip-address>
                        Additional route for this subnet e.g.:
                        destination=10.10.0.0/16,gateway=192.168.71.254
                        destination: destination subnet (in CIDR notation)
                        gateway: nexthop IP address (repeat option to add
                        multiple routes)
  --service-type <service-type>
                        Service type for this subnet e.g.:
                        network:floatingip_agent_gateway. Must be a valid
                        device owner value for a network port (repeat option
                        to set multiple service types)

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


