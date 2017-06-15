#!/bin/bash
BASEDIR="/vagrant/scripts/scripts"
bobfile="$BASEDIR/bob_ssh_key"
janefile="$BASEDIR/jane_ssh_key"
nickfile="$BASEDIR/nick_ssh_key"
chuckfile="$BASEDIR/chuck_ssh_key"
sarafile="$BASEDIR/sara_ssh_key"

if [ ! -f $bobfile ]; then ssh-keygen -t rsa -N "" -b 1024 -f "$bobfile"  -C "openstack tutorial bob bob@os.my.edu"; fi
if [ ! -f $janefile ]; then ssh-keygen -t rsa -N "" -b 1024 -f "$janefile"  -C "openstack tutorial jane jane@os.my.edu";fi
if [ ! -f $nickfile ]; then ssh-keygen -t rsa -N "" -b 1024 -f "$nickfile"  -C "openstack tutorial nick nick@os.my.edu";fi
if [ ! -f $chuckfile ]; then ssh-keygen -t rsa -N "" -b 1024 -f "$chuckfile"  -C "openstack tutorial chuck chuck@os.my.edu";fi
if [ ! -f $sarafile ]; then ssh-keygen -t rsa -N "" -b 1024 -f "$sarafile"  -C "openstack tutorial sara sara@os.my.edu";fi

# ssh-keygen -q silent