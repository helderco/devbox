#!/bin/sh

# Useful stuff
apt-get install -y vim-nox tree pv unzip htop # denyhosts
update-alternatives --set editor /usr/bin/vim.nox

# Install add-apt-repository command
apt-get install -y python-software-properties

# Get git, tig & nodejs
add-apt-repository -y ppa:git-core/ppa
add-apt-repository -y ppa:aguignard/ppa
add-apt-repository -y ppa:chris-lea/node.js
apt-get update

apt-get install -y git tig nodejs

# Get python tools
apt-get install -y python-pip python-dev
pip install --upgrade pip
/usr/local/bin/pip install --upgrade virtualenv

# Ruby gems
apt-get install -y rubygems
