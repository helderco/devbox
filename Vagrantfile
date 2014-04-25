# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define :devbox do |node|
    node.vm.box = "helderco/develop"

    # Network
    node.vm.hostname = "devbox.local"
    # node.vm.network :public_network
    node.vm.network :private_network, ip: "10.10.10.10"
    #node.vm.network :forwarded_port, guest: 80, host: 80
    node.ssh.forward_agent = true

    # Share folders
    node.vm.synced_folder ".", "/vagrant", disabled: true
    node.vm.synced_folder "~", "/host"

    # Use SaltStack for Configuration Management
    node.vm.synced_folder "salt/roots/", "/srv/"

    node.vm.provision :salt do |salt|
      # Configure the minion
      salt.minion_config = "salt/minion.conf"

      # Show the output of salt
      salt.verbose = true

      # Run the highstate on start
      salt.run_highstate = true

      # Install the latest version of SaltStack
      salt.install_type = "daily"
    end

    # Customize VMware
    node.vm.provider :vmware_fusion do |v|
      # v.gui = true
      v.vmx["memsize"] = "2048"
      v.vmx["displayname"] = "devbox"
      v.vmx["tools.upgrade.policy"] = "manual"
      v.mvx["ethernet1.present"] = "TRUE"
      v.mvx["ethernet1.addresstype"] = "generated"
      v.mvx["ethernet1.connectiontype"] = "custom"
      v.mvx["ethernet1.virtualdev"] = "e1000"
      v.mvx["ethernet1.vnet"] = "vmnet2"
    end

    # Customize VirtualBox
    node.vm.provider :virtualbox do |v|
      # v.gui = true
      v.customize ["modifyvm", :id, "--memory", 2048]
    end
  end
end
