# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "trusty64"

  config.vm.network "forwarded_port", guest: 80, host: 80
  config.vm.network "public_network"

  config.ssh.forward_agent = true

  config.vm.provision "shell", path: "provision.sh"

  config.vm.synced_folder "projects/", "/projects"

end
