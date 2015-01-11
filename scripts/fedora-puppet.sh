#! /bin/sh -e

if which puppet > /dev/null 2>&1; then
  echo "Puppet is already installed."
  exit 0
fi

yum install -y ruby puppet
