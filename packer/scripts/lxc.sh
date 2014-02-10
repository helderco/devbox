#!/bin/bash

apt-get install -y lxc redir btrfs-tools apparmor-utils linux-image-generic linux-headers-generic
sudo aa-complain /usr/bin/lxc-start

# Install vagrant
wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.4.2_x86_64.deb -O /tmp/vagrant.deb -q
dpkg -i /tmp/vagrant.deb && rm /tmp/vagrant.deb

# Install the lxc provider
VAGRANT_HOME=/home/vagrant/.vagrant.d su -p vagrant -c 'vagrant plugin install vagrant-lxc'

# Use it as the default
echo -e '\nexport VAGRANT_DEFAULT_PROVIDER=lxc' >> /home/vagrant/.bashrc
