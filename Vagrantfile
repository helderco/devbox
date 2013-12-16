# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Box
  config.vm.box     = "quantal64"
  config.vm.box_url = 'https://github.com/downloads/roderik/VagrantQuantal64Box/quantal64.box'

  # Network
  config.vm.hostname = "devbox.local"
  config.vm.network :private_network, ip: "10.10.10.100"
  config.ssh.forward_agent = true
  config.hostsupdater.aliases = ["dev.bolsasocial.pt"]

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "/Users/heldercorreia/Sites/ata", "/projects/ata"
  config.vm.synced_folder "/Users/heldercorreia/Sites/bolsasocial.pt", "/projects/bolsasocial"

  config.vm.provision :shell, :inline => %[
    if ! $(which lxc-create > /dev/null); then
      apt-get update &&
      apt-get upgrade -y &&
      apt-get install -y lxc redir htop btrfs-tools vim apparmor-utils linux-image-generic linux-headers-generic
    fi

    sudo aa-complain /usr/bin/lxc-start

    if ! $(which vagrant > /dev/null); then
      wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.4.0_x86_64.deb -O /tmp/vagrant.deb -q
      dpkg -i /tmp/vagrant.deb
    fi

    if ! $(grep -q 'VAGRANT_DEFAULT_PROVIDER=lxc' /home/vagrant/.bashrc); then
      echo 'export VAGRANT_DEFAULT_PROVIDER=lxc' >> /home/vagrant/.bashrc
    fi

    VAGRANT_HOME=/home/vagrant/.vagrant.d su -p vagrant -c '
      if ! $(vagrant plugin list | grep -q lxc); then
        vagrant plugin install vagrant-lxc
      fi
    '

    if [ `uname -r` = 3.5.0-17-generic ]; then
      echo "Please restart the machine with 'vagrant reload'"
    fi
  ]

  # Share for masterless server
  config.vm.synced_folder "salt/roots/", "/srv/"

  config.vm.provision :salt do |salt|
    # Configure the minion
    salt.minion_config = "salt/minion.conf"

    # Show the output of salt
    salt.verbose = true

    # Pre-distribute these keys on our local installation
    salt.minion_key = "salt/keys/vagrant.pem"
    salt.minion_pub = "salt/keys/vagrant.pub"

    # Run the highstate on start
    salt.run_highstate = false

    # Install the latest version of SaltStack
    salt.install_type = "daily"
  end


  config.vm.provider "vmware_fusion" do |v|
    v.vmx["memsize"] = "1024"
    v.mvx["ethernet1.present"] = "TRUE"
    v.mvx["ethernet1.addresstype"] = "generated"
    v.mvx["ethernet1.connectiontype"] = "custom"
    v.mvx["ethernet1.virtualdev"] = "e1000"
    v.mvx["ethernet1.vnet"] = "vmnet3"
  end

  # Customize the box
  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--memory", 1024]
    v.customize ["modifyvm", :id, "--nic2", "intnet", "--intnet2", "vagrant"]
  end
end
