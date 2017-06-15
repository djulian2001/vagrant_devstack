#! /bin/bash

sudo apt-get update
sudo apt-get install -y git
sudo groupadd stack
sudo useradd --create-home -g stack stack
echo "stack:stack" | sudo chpasswd
sudo sh -c "echo 'stack  ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers"
sudo -u stack git clone --branch stable/ocata https://github.com/openstack-dev/devstack.git /home/stack/devstack
sudo -u stack /home/stack/devstack/tools/create-stack-user.sh 
sudo -u stack cp /vagrant/local.conf /home/stack/devstack
sudo -u stack -H /home/stack/devstack/stack.sh
