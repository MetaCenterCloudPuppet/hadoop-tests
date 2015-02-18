include stdlib

case $::osfamily {
  'Debian': {
    $hdfs_hostname = 'deb-pig-hdfs.vagrant'
    $yarn_hostname = 'deb-pig-yarn.vagrant'
    $slaves = [ 'deb-pig-node.vagrant' ]
    $frontends = [ 'deb-pig-node.vagrant' ]
  }
  'RedHat': {
    $hdfs_hostname = 'fed-pig-hdfs.vagrant'
    $yarn_hostname = 'fed-pig-yarn.vagrant'
    $slaves = [ 'fed-pig-node.vagrant' ]
    $frontends = [ 'fed-pig-node.vagrant' ]
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

node 'deb-pig-hdfs', 'fed-pig-hdfs' {
  include hadoop::namenode
  include site_hadoop::devel::hadoop

  Class['hadoop::namenode'] -> Class['site_hadoop::devel::hadoop']
}

node 'deb-pig-yarn', 'fed-pig-yarn' {
  include hadoop::resourcemanager
  include hadoop::historyserver
}

node 'deb-pig-node', 'fed-pig-node' {
  include hadoop::datanode
  include hadoop::nodemanager
  include hadoop::frontend
  include pig
}
