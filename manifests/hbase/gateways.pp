$external_zookeeper = $::operatingsystem ? {
  fedora  => false,
  default => true,
}

class{'hadoop':
  hdfs_hostname => $::fqdn,
  yarn_hostname => $::fqdn,
  slaves => [ $::fqdn ],
  frontends => [ $::fqdn ],
  realm => '',
  properties => {
    'dfs.replication' => 1,
  },
  features => {
    yellowmanager => true,
  },
}

class{'hbase':
  hdfs_hostname => $::fqdn,
  master_hostname => $::fqdn,
  rest_hostnames => [ $::fqdn ],
  thrift_hostnames => [ $::fqdn ],
  zookeeper_hostnames => [ $::fqdn ],
  external_zookeeper => $external_zookeeper,
  slaves => [ $::fqdn ],
  frontends => [ $::fqdn ],
  realm => '',
  features => {
    hbmanager => true,
  },
}

node default {
  include stdlib

  include hadoop::namenode
  include hadoop::resourcemanager
  include hadoop::historyserver
  include hadoop::datanode
  include hadoop::nodemanager
  include hadoop::frontend
  include hbase::master
  include hbase::regionserver
  include hbase::restserver
  include hbase::thriftserver
  include hbase::frontend
  include hbase::hdfs

  class{'site_hadoop':
    mirror => 'scientific',
    stage  => 'setup',
  }
  include site_hadoop::devel::hadoop

  if $external_zookeeper {
    class{'zookeeper':
      hostnames => [ $::fqdn ],
      realm => '',
    }
  } else {
    include hbase::zookeeper
  }

  Class['hadoop::namenode::service'] -> Class['site_hadoop::devel::hadoop']
  Class['hadoop::namenode::service'] -> Class['hbase::master::service']
}
