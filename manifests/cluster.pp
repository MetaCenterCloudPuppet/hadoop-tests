include stdlib

case $::osfamily {
  'Debian': {
    $hdfs_hostname = 'deb-hdfs.vagrant'
    $yarn_hostname = 'deb-yarn.vagrant'
    $slaves = [ 'deb-node.vagrant' ]
    $frontends = [ 'deb-node.vagrant' ]
  }
  'RedHat': {
    $hdfs_hostname = 'fed-hdfs.vagrant'
    $yarn_hostname = 'fed-yarn.vagrant'
    $slaves = [ 'fed-node.vagrant' ]
    $frontends = [ 'fed-node.vagrant' ]
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

node 'deb-hdfs', 'fed-hdfs' {
  include hadoop::namenode
  include site_hadoop::devel::hadoop

  Class['hadoop::namenode'] -> Class['site_hadoop::devel::hadoop']
}

node 'deb-yarn', 'fed-yarn' {
  include hadoop::resourcemanager
  include hadoop::historyserver
}

node 'deb-node', 'fed-node' {
  include hadoop::datanode
  include hadoop::nodemanager
  include hadoop::frontend
}
