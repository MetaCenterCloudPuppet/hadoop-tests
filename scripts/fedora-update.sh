#! /bin/bash -xe

if test ! -f /etc/yum.repos.d/rpmfusion-nonfree.repo; then
  wget -nv http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-21.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-21.noarch.rpm
  yum install -y ./rpmfusion-*.rpm
  yum remove -y kmod-VirtualBox\*
  yum upgrade -y
  yum install -y VirtualBox-guest || :
fi

if test -f /lib/systemd/system/firewalld.service; then
  service firewalld stop || :
  yum remove -y firewalld
  iptables-restore << EOF
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
COMMIT
EOF

fi

yum upgrade -y
