#! /bin/bash -xe

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
