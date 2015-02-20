include stdlib

case $::osfamily {
  'Debian': {
    $hostnames = ['deb-zoo1.vagrant', 'deb-zoo2.vagrant', 'deb-zoo3.vagrant' ]
  }
  'RedHat': {
    $hostnames = ['fed-zoo1.vagrant', 'fed-zoo2.vagrant', 'fed-zoo3.vagrant' ]
  }
}

class{'site_hadoop':
  mirror => 'scientific',
  stage  => 'setup',
}

node default {
  class{"zookeeper":
    hostnames => $hostnames,
    realm => '',
  }
}
