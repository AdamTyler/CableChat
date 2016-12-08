# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network :forwarded_port, guest: 3005, host: 3005 # Web Port
  config.vm.network :forwarded_port, guest: 6379, host: 6379 # Redis Port
  # config.vm.network :private_network, ip: "10.0.0.15", virtualbox__intnet: true
  config.vm.network :private_network, ip: "10.11.12.16"
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    v.customize ["modifyvm", :id, "--memory", "1024"]
  end
  config.vm.provision "shell", path: "vagrant/provision.sh"
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
end
