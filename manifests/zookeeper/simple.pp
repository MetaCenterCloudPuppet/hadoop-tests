include stdlib

class{'site_hadoop':
  mirror => 'scientific',
  stage  => 'setup',
}

node default {
  class{"zookeeper":
    hostnames => [ $::fqdn ],
    realm => '',
  }
}
