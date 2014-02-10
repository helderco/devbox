# Disable DNS reverse lookups in sshd
# (they’re pointless in a local VM and cause unnecessary connection delay)
/etc/ssh/sshd_config:
  file:
    - append
    - text: UseDNS=no
