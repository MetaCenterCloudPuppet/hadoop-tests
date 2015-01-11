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
  zookeeper_hostnames => [ $::fqdn ],
  external_zookeeper => false,
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
  include hbase::frontend
  include hbase::zookeeper
  include hbase::hdfs

  class{'site_hadoop':
    mirror => 'scientific',
    stage  => 'setup',
  }
  include site_hadoop::devel::hadoop

  Class['hadoop::namenode::service'] -> Class['site_hadoop::devel::hadoop']
  Class['hadoop::namenode::service'] -> Class['hbase::hdfs']
  Class['hadoop::namenode::service'] -> Class['hbase::master::service']
}
