
/root/fix_vmware.sh:
  file:
    - managed
    - source: salt://fusion/fix_vmware.sh
    - mode: 710
