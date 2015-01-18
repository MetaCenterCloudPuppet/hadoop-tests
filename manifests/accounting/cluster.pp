include stdlib

case $::osfamily {
  'Debian': {
    $hdfs_hostname = 'deb-acc-hdfs.vagrant'
    $yarn_hostname = 'deb-acc-yarn.vagrant'
    $slaves = [ 'deb-acc-node.vagrant' ]
    $frontends = [ 'deb-acc-node.vagrant' ]
  }
  'RedHat': {
    $hdfs_hostname = 'fed-acc-hdfs.vagrant'
    $yarn_hostname = 'fed-acc-yarn.vagrant'
    $slaves = [ 'fed-acc-node.vagrant' ]
    $frontends = [ 'fed-acc-node.vagrant' ]
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

node 'deb-acc-hdfs', 'fed-acc-hdfs' {
  include hadoop::namenode
  include site_hadoop::devel::hadoop

  class{'site_hadoop::accounting':
    db_user     => 'accounting',
    db_password => 'accpass',
    accounting_hdfs  => '* * * * *',
    accounting_quota => '* * * * *',
    accounting_jobs  => '10 0 * * *',
    mapred_hostname => $yarn_hostname,
    principal   => '',
  }

  class{'mysql::server':
    root_password => 'strong_password',
  }
  mysql::db{'accounting':
    user     => 'accounting',
    password => 'accpass',
    sql      => '/usr/local/share/hadoop/accounting.sql',
  }

  Class['hadoop::namenode'] -> Class['site_hadoop::devel::hadoop']
  Class['site_hadoop::accounting'] -> Mysql::Db['accounting']
  Class['hadoop::namenode::install'] -> Class['site_hadoop::accounting']
}

node 'deb-acc-yarn', 'fed-acc-yarn' {
  include hadoop::resourcemanager
  include hadoop::historyserver
}

node 'deb-acc-node', 'fed-acc-node' {
  include hadoop::datanode
  include hadoop::nodemanager
  include hadoop::frontend
}
