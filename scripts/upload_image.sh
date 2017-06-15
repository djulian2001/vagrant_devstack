#!/bin/bash

admin_project_id=$( openstack project show -f value -c id "admin" )

image_dir="/vagrant/scripts/images"
image_name="CentOS-7-x86_64-GenericCloud-1607"
image_file="$image_name".qcow2

if [ ! -f "$image_dir/$image_file" ]; then
	cd "$image_dir"
	# ADD a sha check....
	# https://help.ubuntu.com/community/HowToSHA256SUM
	
	wget -c http://cloud.centos.org/centos/7/images/sha256sum.txt.asc

	wget -c http://cloud.centos.org/centos/7/images/"$image_file".xz
	xz --decompress "$image_file".xz

fi


	


image_id=$( openstack image show -f value -c id "$image_name" )
if [ $? -ne 0 ]; then
	image_id=$( openstack image create -f value -c id \
		--disk-format "qcow2" \
		--min-disk 1 \
		--min-ram 128 \
		--file /vagrant/"$image_name".qcow2 \
		--project "$admin_project_id" \
		--public \
		--unprotected \
	"$image_name" )
fi
