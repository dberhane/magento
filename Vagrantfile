# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu/trusty64"

  #config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
   config.vm.network "private_network", ip: "192.168.33.10"
config.vm.hostname = "magento.vbox.local"

if defined? VagrantPlugins::HostsUpdater
    config.hostsupdater.aliases = [
      "magento.vbox.local",
      "magento.myvbox.com",
      "magentotest.vbox.local",
    ]
end

# Check whether default CPU and memory settings for your VM
config.vm.provider "virtualbox" do |v|
  v.customize ["modifyvm", :id, "--cpuexecutioncap", "90"]
  v.customize ["modifyvm", :id, "--memory", "2048"]
  v.customize ["modifyvm", :id, "--cpus", 2]
end


  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false

  config.ssh.private_key_path = [ '~/.ssh/insecure_private_key', '~/.ssh/id_rsa' ]
  config.ssh.forward_agent = true

   config.vm.provision "puppet" do |puppet|
     puppet.manifests_path = "manifests"
     puppet.manifest_file  = "default.pp"
     puppet.module_path = "modules"
     puppet.options = "--verbose --debug"
   end

end
