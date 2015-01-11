#! /bin/sh -e
if grep -q '^Debian' /etc/issue; then
  `dirname $0`/debian-update.sh
  `dirname $0`/debian-puppet.sh
elif grep -q '^Fedora' /etc/issue; then
  `dirname $0`/fedora-update.sh
  `dirname $0`/fedora-puppet.sh
fi
