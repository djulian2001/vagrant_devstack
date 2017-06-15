# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "bento/ubuntu-16.04"
  config.vm.box_version = "2.2.9"

  # USE this for mac with virtualbox
  config.vm.network "private_network", ip: "192.168.33.111"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 5000, host: 5000
  config.vm.network "forwarded_port", guest: 9696, host: 9696
  config.vm.network "forwarded_port", guest: 8774, host: 8774 
  config.vm.network "forwarded_port", guest: 35357, host: 35357

  # USE This for windows 10 with virtualbox
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  # config.vm.network "forwarded_port", guest: 5000, host: 5000, host_ip: "127.0.0.1"
  # config.vm.network "forwarded_port", guest: 9696, host: 9696, host_ip: "127.0.0.1"
  # config.vm.network "forwarded_port", guest: 8774, host: 8774 , host_ip: "127.0.0.1"
  # config.vm.network "forwarded_port", guest: 35357, host: 35357, host_ip: "127.0.0.1"

  # For VirtualBox Provider use the following:
  config.vm.provider "virtualbox" do |vb|
    vb.name = "rc_devstack_min_ubuntu16041"
    vb.memory = 6144
    vb.cpus = 2
    vb.customize ["modifyvm", :id, "--cableconnected1", "on"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  # for hyper-v using the following:
  # source: https://www.vagrantup.com/docs/hyperv/configuration.html
  # uncomment out below block and comment out above block.
  # NOTE: huper-v boxes (above) would also have to be supported, aka the box has to
  # be built with the hyper visor provider in mind, bento doesn't support any hyperv
  # I can't test hyperv.  Please provide a pull request if you get a working config

  # config.vm.provider "hyperv" do |h|
  #   # I am unable to test against hyperv, reference source, also the limitations
  #   # on networking might impact this up, please submit pull requests if you find
  #   # a working config. 
  #   h.vmname = "rc_devstack_min_ubuntu16041"
  #   h.memory = 6144
  #   h.cpus = 2
  # end

  config.vm.provision "shell" do |sh_cnd2|
      sh_cnd2.path = "vm_stack.sh"    
  end

end
