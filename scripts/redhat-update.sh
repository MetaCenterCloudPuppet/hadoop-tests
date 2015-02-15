#! /bin/bash -xe

cat > /etc/sysconfig/iptables <<EOF
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
COMMIT
EOF
iptables-restore < /etc/sysconfig/iptables

cp -p /etc/sysconfig/iptables /etc/sysconfig/ip6tables
ip6tables-restore < /etc/sysconfig/ip6tables

yum upgrade -y
