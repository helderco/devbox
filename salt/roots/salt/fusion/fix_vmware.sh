#!/bin/sh
#
# Slow/nonexistent sync for shared folders in VMWare Fusion 6.0.2
#  - https://communities.vmware.com/thread/462543

VT_FILE="com.vmware.fusion.tools.linux.zip"
OUT_DIR="vmware_tools_601"

cd /tmp
wget -N https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/6.0.1/1331545/packages/$VT_FILE.tar
tar xvf $VT_FILE.tar
which unzip || apt-get install unzip
unzip $VT_FILE -d $OUT_DIR

# Install the VMware Fusion guest tools
mkdir -p /mnt/cdrom
mount -o loop /tmp/$OUT_DIR/payload/linux.iso /mnt/cdrom
tar zxf /mnt/cdrom/VMwareTools-*.tar.gz -C /tmp/
/tmp/vmware-tools-distrib/vmware-install.pl -d
rm -r $OUT_DIR $VT_FILE*
umount /mnt/cdrom
