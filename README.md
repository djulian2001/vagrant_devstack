# About this Repo

This repo is intended to get a vagrant env with devstack running.

# Requirements

virtualbox ( https://www.virtualbox.org/wiki/Downloads )

vagrant ( https://www.vagrantup.com/downloads.html )

optional vagrant plugin ( https://github.com/dotless-de/vagrant-vbguest )

	The virtualbox guest additions has caused me issues, I added the plugin to help deal with
	those bugs.

# Whats inside

Vagrant Box: bento/ubuntu-16.04

The latest version of devstack

# How to use.

create your working directory and change into that directory
	
	$ mkdir mydevstack/
	$ cd mydevstack

clone this repository into your empty working directory
	
	$ git clone https://github.com/primusdj/vagrant-devstack.git .

and now it is just...
	
	$ vagrant up

# working with the env

ssh onto the box
	
	$ vagrant ssh

horizons dashboard will be (or whatever you set as your host ip address to)
	
	http://192.168.33.111/dashboard


