include stdlib

case $::osfamily {
  'Debian': {
    $master1 = 'deb-hamaster1.vagrant'
    $master2 = 'deb-hamaster2.vagrant'
    $slaves = [ 'deb-hanode.vagrant' ]
    $frontends = [ 'deb-hanode.vagrant' ]
    $historyserver_hostname = 'deb-hanode.vagrant'
    $zoo = [ $master1, $master2, 'deb-hanode.vagrant' ]
    $journalnode_hostnames = $zoo
  }
  'RedHat': {
    $master1 = 'fed-hamaster1.vagrant'
    $master2 = 'fed-hamaster2.vagrant'
    $slaves = [ 'fed-hanode.vagrant' ]
    $frontends = [ 'fed-hanode.vagrant' ]
    $historyserver_hostname = 'fed-hanode.vagrant'
    $zoo = [ $master1, $master2, 'fed-hanode.vagrant' ]
    $journalnode_hostnames = $zoo
  }
}
$zoo_deployed=true
$hdfs_deployed=true

class{'hadoop':
  hdfs_hostname          => $master1,
  hdfs_hostname2         => $master2,
  yarn_hostname          => $master1,
  yarn_hostname2         => $master2,
  historyserver_hostname => $historyserver_hostname,
  journalnode_hostnames  => $journalnode_hostnames,
  zookeeper_hostnames    => $zoo,
  slaves                 => $slaves,
  frontends              => $frontends,
  realm                  => '',
  properties             => {
    'dfs.replication' => 1,
  },
  features               => {
    yellowmanager => true,
  },

  hdfs_deployed          => $hdfs_deployed,
  zookeeper_deployed     => $zoo_deployed,
}

class{'site_hadoop':
  mirror => 'scientific',
  stage  => 'setup',
}

node 'deb-hamaster1', 'fed-hamaster1' {
  include hadoop::namenode
  include hadoop::resourcemanager
  include hadoop::zkfc
  include hadoop::journalnode

  class{'zookeeper':
    realm => '',
    hostnames => $zoo,
  }

  if $zoo_deployed {
    include site_hadoop::devel::hadoop

    Class['hadoop::namenode'] -> Class['site_hadoop::devel::hadoop']
  }
}

node 'deb-hamaster2', 'fed-hamaster2' {
  include hadoop::namenode
  include hadoop::resourcemanager
  include hadoop::zkfc
  include hadoop::journalnode

  class{'zookeeper':
    realm => '',
    hostnames => $zoo,
  }
}

node 'deb-hanode', 'fed-hanode' {
  include hadoop::datanode
  include hadoop::nodemanager
  include hadoop::historyserver
  include hadoop::journalnode
  include hadoop::frontend

  class{'zookeeper':
    realm => '',
    hostnames => $zoo,
  }
}
