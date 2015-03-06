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

node default {
  include stdlib

  include hadoop::namenode
  include hadoop::resourcemanager
  include hadoop::historyserver
  include hadoop::datanode
  include hadoop::nodemanager
  include hadoop::frontend
  class{'site_hadoop':
    mirror => 'scientific',
    stage  => 'setup',
  }
  include site_hadoop::devel::hadoop
  class{'site_hadoop::bookkeeping':
    db_name     => 'bookkeeping',
    db_user     => 'bookkeeping',
    db_password => 'bkpass',
    freq        => '*/2 * * * *',
    interval    => 3600,
  }
  class{'mysql::server':
    root_password => 'strong_password',
  }
  mysql::db{'bookkeeping':
    user     => 'bookkeeping',
    password => 'bkpass',
    sql      => '/usr/local/share/hadoop/bookkeeping.sql',
  }

  Class['hadoop::namenode::service'] -> Class['site_hadoop::devel::hadoop']
  Class['site_hadoop::bookkeeping'] -> Mysql::Db['bookkeeping']
}
