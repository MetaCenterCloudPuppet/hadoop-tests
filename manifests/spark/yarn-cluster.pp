include stdlib

case $::osfamily {
  'Debian': {
    $hdfs_hostname = 'deb-spark-hdfs.vagrant'
    $yarn_hostname = 'deb-spark-yarn.vagrant'
    $slaves = [ 'deb-spark-node.vagrant' ]
    $frontends = [ 'deb-spark-frontend.vagrant' ]
  }
  'RedHat': {
    $hdfs_hostname = 'fed-spark-hdfs.vagrant'
    $yarn_hostname = 'fed-spark-yarn.vagrant'
    $slaves = [ 'fed-spark-node.vagrant' ]
    $frontends = [ 'fed-spark-frontend.vagrant' ]
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
    aggregation   => true,
    yellowmanager => true,
  },
}

class{'site_hadoop':
  mirror => 'scientific',
  stage  => 'setup',
}

class{'spark':
  hdfs_hostname => $hdfs_hostname,
}

node 'deb-spark-hdfs', 'fed-spark-hdfs' {
  include hadoop::namenode
  include spark::hdfs
  include site_hadoop::devel::hadoop

  Class['hadoop::namenode::service'] -> Class['site_hadoop::devel::hadoop']
  Class['hadoop::namenode::service'] -> Class['spark::hdfs']
}

node 'deb-spark-yarn', 'fed-spark-yarn' {
  include hadoop::resourcemanager
  include hadoop::historyserver
}

node 'deb-spark-node', 'fed-spark-node' {
  include hadoop::datanode
  include hadoop::nodemanager
}

node 'deb-spark-frontend', 'fed-spark-frontend' {
#  include hadoop::frontend
  include hadoop::common::config
  include hadoop::common::hdfs::config
  include hadoop::common::yarn::config
  include spark::frontend
}
