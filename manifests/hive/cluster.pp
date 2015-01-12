include stdlib

case $::osfamily {
  'Debian': {
    $hdfs_hostname = 'deb-hive-hdfs.vagrant'
    $yarn_hostname = 'deb-hive-yarn.vagrant'
    $slaves = [ 'deb-hive-node.vagrant' ]
    $frontends = [ 'deb-hive-node.vagrant' ]
  }
  'RedHat': {
    $hdfs_hostname = 'fed-hive-hdfs.vagrant'
    $yarn_hostname = 'fed-hive-yarn.vagrant'
    $slaves = [ 'fed-hive-node.vagrant' ]
    $frontends = [ 'fed-hive-node.vagrant' ]
  }
}

class{'hadoop':
  hdfs_hostname => $hdfs_hostname,
  yarn_hostname => $yarn_hostname,
  slaves        => $slaves,
  frontends     => $frontends,
  realm         => '',
  properties    => {
    'dfs.replication' => 1,
  },
  features      => {
    yellowmanager => true,
  },
}

class{'site_hadoop':
  mirror => 'scientific',
  stage  => 'setup',
}

class{'hive':
  metastore_hostname => $hdfs_hostname,
  server2_hostname => $yarn_hostname,
  group => 'vagrant',
  realm => '',
  features => {
    manager => true,
  },
}

node 'deb-hdfs', 'fed-hdfs' {
  include hadoop::namenode
  include site_hadoop::devel::hadoop
  include hive::hdfs
  include hive::metastore

  Class['hadoop::namenode'] -> Class['site_hadoop::devel::hadoop']
  Class['hadoop::namenode::service'] -> Class['hive::hdfs']
  Class['hadoop::namenode::service'] -> Class['hive::metastore::service']
}

node 'deb-yarn', 'fed-yarn' {
  include hadoop::resourcemanager
  include hadoop::historyserver
  include hive::server2
}

node 'deb-node', 'fed-node' {
  include hadoop::datanode
  include hadoop::nodemanager
  include hadoop::frontend
  include hive::frontend
  include hive::hcatalog
}
