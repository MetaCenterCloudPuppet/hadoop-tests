#! /bin/sh -e

apt-get purge -y nano
apt-get update
apt-get dist-upgrade -y
