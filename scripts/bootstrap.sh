#! /bin/sh -e
if grep -q '^Debian' /etc/issue; then
  `dirname $0`/debian-update.sh
  `dirname $0`/debian-puppet.sh
elif grep -q '^Ubuntu' /etc/issue; then
  `dirname $0`/debian-update.sh
  `dirname $0`/ubuntu-puppet.sh
elif grep -q '^Fedora' /etc/issue; then
  `dirname $0`/fedora-update.sh
  `dirname $0`/fedora-puppet.sh
elif grep -q '^\(RedHat\|CentOS\)' /etc/issue; then
  major=`sed -e 's/.*release \([0-9]\+\).*/\1/' /etc/redhat-release`
  `dirname $0`/rhel6-puppet.sh
  `dirname $0`/redhat-update.sh
fi
# workaround problem with libvirt+KVM
ifdown eth1
ifup eth1
