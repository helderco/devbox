
ufw:
  pkg:
    - installed

ufw allow in on lxcbr0:
  cmd:
    - run

ufw allow out on lxcbr0:
  cmd:
    - run

/etc/default/ufw:
  file:
    - replace
    - pattern: '.*DEFAULT_FORWARD_POLICY=\"[A-Z]+\"'
    - repl: DEFAULT_FORWARD_POLICY="ACCEPT"

# /tmp/vagrant.deb:
#   file:
#     - managed
#     - source: https://dl.bintray.com/mitchellh/vagrant/vagrant_1.4.1_x86_64.deb
#     - source_hash: sha256=27748094f15ff708cd0d130e4a2e30e4722aecc562901a3f204e6e36dbe1013e

# dpkg -i /tmp/vagrant.deb:
#   cmd:
#     - run
#     - unless: which vagrant

# vagrant-lxc:
#   cmd:
#     - run
#     - name: vagrant plugin install vagrant-lxc
#     - unless: vagrant plugin list | grep -q vagrant-lxc
#     - user: vagrant
#     - env:
#       - VAGRANT_HOME: /home/vagrant/.vagrant.d

# /home/vagrant/.bashrc:
#   file:
#     - append
#     - text: |
#         export VAGRANT_DEFAULT_PROVIDER=lxc

/home/vagrant/box:
  file:
    - recurse
    - source: salt://lxc/box
    - exclude_pat: .*.DS_Store
    - user: vagrant
    - group: vagrant

/home/vagrant/box/build-ubuntu.sh:
  file:
    - managed
    - mode: 710
